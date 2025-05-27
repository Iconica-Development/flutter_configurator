import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/configurator_node.dart";
import "package:flutter_configurator/src/models/configurator_options.dart";
import "package:flutter_configurator/src/ui/widgets/configuration_step.dart";
import "package:flutter_configurator/src/ui/widgets/stepper_nodes.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_stepper/stepper.dart";

/// An [InheritedWidget] that provides [ConfiguratorOptions] to its descendants.
class ConfiguratorScope extends InheritedWidget {
  /// Creates a [ConfiguratorScope] that provides the given [options]
  /// to the widget subtree.
  const ConfiguratorScope({
    required this.options,
    required super.child,
    super.key,
  });

  /// The [ConfiguratorOptions] to be provided to the widget subtree.
  final ConfiguratorOptions options;

  /// Retrieves the nearest [ConfiguratorOptions] up the widget tree.
  static ConfiguratorOptions of(BuildContext context) {
    var provider =
        context.dependOnInheritedWidgetOfExactType<ConfiguratorScope>();
    assert(provider != null, "No ConfiguratorOptionsProvider found in context");
    return provider!.options;
  }

  @override
  bool updateShouldNotify(ConfiguratorScope oldWidget) =>
      options != oldWidget.options;
}

///
class ConfiguratorUserstory extends StatelessWidget {
  ///
  const ConfiguratorUserstory({
    required this.options,
    super.key,
  });

  /// The [ConfiguratorOptions] for this user story.
  final ConfiguratorOptions options;

  @override
  Widget build(BuildContext context) => ConfiguratorScope(
        options: options,
        child: const _ConfiguratorUserstoryContent(),
      );
}

/// The internal content of [ConfiguratorUserstory],
/// separated to allow [ConfiguratorScope] wrapping.
class _ConfiguratorUserstoryContent extends HookWidget {
  const _ConfiguratorUserstoryContent();

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    var currentValues = useState<Map<String, dynamic>>({});
    var savedValues = useState<Map<String, dynamic>>({});

    var visitedNodes = useState<List<ConfiguratorNode>>([options.initialnode]);
    var currentNode = visitedNodes.value.last;
    var currentStep = visitedNodes.value.length - 1;
    var amountOfTotalSteps = useMemoized(
      () =>
          currentNode.amountOfTotalSteps?.call(currentValues.value) ??
          currentStep,
      [currentNode],
    );

    var currentPage = useMemoized(
      () => options.getAllConfigurationSteps(context)[currentNode.stepKey],
      [currentNode.stepKey],
    );

    String? validateStep() {
      var sectionValidationMessage = currentPage?.sections
          .map(
            (section) => section.validationFunction?.call(currentValues.value),
          )
          .firstWhere(
            (validationMessage) => validationMessage != null,
            orElse: () => null,
          );
      if (sectionValidationMessage != null) {
        return sectionValidationMessage;
      }

      var stepValidationMessage = currentPage?.validationFunction?.call(
        currentValues.value,
      );
      if (stepValidationMessage != null) {
        return stepValidationMessage;
      }
      var inputValidationMessage = currentPage?.sections
          .map(
            (section) => section.inputs
                .map(
                  (input) => input.validator.call(currentValues.value),
                )
                .firstWhere(
                  (validationMessage) => validationMessage != null,
                  orElse: () => null,
                ),
          )
          .firstWhere(
            (validationMessage) => validationMessage != null,
            orElse: () => null,
          );

      return inputValidationMessage;
    }

    var validationMessage = useMemoized(
      validateStep,
      [currentValues.value, currentPage],
    );

    var isValid = validationMessage == null;

    var isLastStep = amountOfTotalSteps == currentStep + 1;
    var isFirstStep = currentStep == 0;

    void onNextPage() {
      var nextNode = currentNode.nextStep?.call(currentValues.value);
      if (nextNode != null) {
        visitedNodes.value = [...visitedNodes.value, nextNode];
      }
      savedValues.value = currentValues.value;
    }

    useEffect(
      () {
        if (isLastStep) {
          options.onConfiguratorLastStepReached?.call(currentValues.value);
        }
        return;
      },
      [isLastStep],
    );

    void onPreviousPage() {
      if (visitedNodes.value.length <= 1) return;
      visitedNodes.value =
          visitedNodes.value.sublist(0, visitedNodes.value.length - 1);
      currentValues.value = savedValues.value;
    }

    var steps = [
      // fill it up with empty steps before the current step
      for (var i = 0; i < currentStep; i++) ...[
        const MultiViewStep(
          title: "empty",
          content: SizedBox.shrink(),
        ),
      ],
      if (currentPage != null) ...[
        MultiViewStep(
          title: currentPage.title,
          content: Padding(
            padding: options.contentPadding ??
                const EdgeInsets.only(
                  right: 60,
                  bottom: 40,
                ),
            child: ConfiguratorStepDisplay(
              step: currentPage,
              isLastStep: isLastStep,
              onpressBack: onPreviousPage,
              values: currentValues.value,
              onValueChanged: (value) {
                currentValues.value = {
                  ...currentValues.value,
                  ...value,
                };
              },
            ),
          ),
        ),
      ],
      // fill it up with empty steps after the current step
      for (var i = currentStep + 1; i < amountOfTotalSteps; i++) ...[
        const MultiViewStep(
          title: "empty",
          content: SizedBox.shrink(),
        ),
      ],
    ];

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, top: isFirstStep ? 58 : 0),
          child: MultiStepperView(
            showAllSteps: true,
            currentStep: currentStep,
            zeroIndexed: true,
            showOnlyCurrentStep: true,
            theme: StepperTheme(
              linePadding: 10,
              paddingTopForCenterContent: isFirstStep ? 10 : 60,
              hideStepWhenDone: true,
              emptyHeight: 130,
              activeLineColor: options.configuratorColorOptions.activeLineColor,
              lineColor:
                  options.configuratorColorOptions.lineColor ?? Colors.black,
              useDashedLine: true,
              stepIndicatorTheme: StepIndicatorTheme(
                builder: (stepIndex, currentIndex) {
                  var isCurrentStep = stepIndex == currentIndex;
                  return StepperNodeCircle(
                    isCurrentStep: isCurrentStep,
                    currentindex: stepIndex + 1,
                  );
                },
                lastBuilder: (stepIndex, currentIndex) =>
                    const StepperLastNodeCircle(),
              ),
            ),
            steps: steps,
          ),
        ),
        if (!isLastStep) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: options.nextButtonPadding ??
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: options.primaryButtonBuilder(
                context,
                text: options.nextButtonText,
                onPressed: isValid ? onNextPage : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
