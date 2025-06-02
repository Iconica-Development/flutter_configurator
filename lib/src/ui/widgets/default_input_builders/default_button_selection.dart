import "package:flutter/material.dart";
import "package:flutter_configurator/flutter_configurator.dart";

///
class DefaultButtonSelection extends StatelessWidget {
  ///
  const DefaultButtonSelection({
    required this.inputField,
    required this.onPressed,
    required this.values,
    super.key,
  });

  ///
  final ConfiguratorButtonSelection inputField;

  ///
  final void Function(String value) onPressed;

  ///
  final Map<String, dynamic> values;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorButtonSelection inputField,
    required void Function(String value) onPressed,
    required Map<String, dynamic> values,
  }) =>
      DefaultButtonSelection(
        inputField: inputField,
        onPressed: onPressed,
        values: values,
      );

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 32,
        runSpacing: 32,
        children: [
          ...inputField.options.map(
            (option) => DefaultButtonSelectionButton(
              inputField: inputField,
              option: option,
              onPressed: () => onPressed(option.value),
              isSelected: values[inputField.key] == option.value,
              values: values,
            ),
          ),
        ],
      );
}

///
class DefaultButtonSelectionButton extends StatelessWidget {
  ///
  const DefaultButtonSelectionButton({
    required this.option,
    required this.isSelected,
    required this.values,
    required this.inputField,
    this.onPressed,
    super.key,
  });

  ///
  final ConfiguratorButtonSelectionOption option;

  ///
  final VoidCallback? onPressed;

  ///
  final bool isSelected;

  ///
  final Map<String, dynamic> values;

  ///
  final ConfiguratorButtonSelection inputField;

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    var primaryisSelected = values[inputField.key] != option.value;
    var stepExists = values.containsKey(inputField.key);

    return option.image.isEmpty
        ? options.primaryButtonBuilder(
            context,
            text: option.label,
            onPressed: stepExists && primaryisSelected ? null : onPressed,
            onDisablePressed: () => onPressed?.call(),
            width: 225,
          )
        : Column(
            children: [
              ElevatedButton(
                statesController: WidgetStatesController(
                  <WidgetState>{
                    if (isSelected) WidgetState.selected,
                  },
                ),
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    option.padding ?? EdgeInsets.zero,
                  ),
                  fixedSize: const WidgetStatePropertyAll(
                    Size(175, 175),
                  ),
                  elevation: const WidgetStatePropertyAll(5),
                ),
                onPressed: () {
                  onPressed?.call();
                },
                child: option.image != ""
                    ? ClipRRect(
                        borderRadius: option.padding != null
                            ? BorderRadius.zero
                            : BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Image.asset(
                              option.image,
                              fit: BoxFit.cover,
                              width: 175,
                            ),
                            if (!isSelected && stepExists) ...[
                              Container(
                                color: Colors.white.withAlpha(150),
                              ),
                            ],
                          ],
                        ),
                      )
                    : const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.black,
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 175,
                child: Text(
                  option.label,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
  }
}
