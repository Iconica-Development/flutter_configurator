import "package:flutter/material.dart";
import "package:flutter_configurator/src/ui/configurator_userstory.dart";

/// A circular widget representing a step in the stepper.
///
/// Highlights the node if it is the current step, otherwise uses a default
/// style.
///
/// [isCurrentStep] - Whether this node is the current step.
/// [currentindex] - The index of the step.
/// [options] - Configuration options for styling.
class StepperNodeCircle extends StatelessWidget {
  ///
  const StepperNodeCircle({
    required this.isCurrentStep,
    required this.currentindex,
    super.key,
  });

  /// Whether this node is the current step.
  final bool isCurrentStep;

  /// The index of the step represented by this node.
  final int currentindex;

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var node = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isCurrentStep
            ? options.configuratorColorOptions.activeStepsNodeColor
            : options.configuratorColorOptions.nextStepsNodeColor,
      ),
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          currentindex.toString(),
          style: textTheme.titleMedium
              ?.copyWith(color: isCurrentStep ? Colors.white : null),
        ),
      ),
    );

    if (isCurrentStep) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: options.configuratorColorOptions.currentStepOutlineColor,
        ),
        width: 60,
        height: 60,
        child: Center(child: node),
      );
    } else {
      return node;
    }
  }
}

/// A circular widget representing the last node in the stepper.
///
/// Displays a check icon and uses the final step color from [options].
class StepperLastNodeCircle extends StatelessWidget {
  ///
  const StepperLastNodeCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    return CircleAvatar(
      backgroundColor: options.configuratorColorOptions.finalStepNodeColor,
      child: const Icon(Icons.check),
    );
  }
}
