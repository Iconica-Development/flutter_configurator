import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/configurator_userstory.dart";

///
class DefaultYesNoButton extends StatelessWidget {
  ///
  const DefaultYesNoButton({
    required this.inputField,
    required this.onPressed,
    required this.values,
    super.key,
  });

  ///
  final ConfiguratorYesNoButton inputField;

  ///
  final ValueChanged<bool?> onPressed;

  ///
  final Map<String, dynamic> values;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorYesNoButton inputField,
    required ValueChanged<bool?> onPressed,
    required Map<String, dynamic> values,
  }) =>
      DefaultYesNoButton(
        inputField: inputField,
        onPressed: onPressed,
        values: values,
      );

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    var currentValue = values[inputField.key];
    VoidCallback? onYesPressed;
    VoidCallback? onNoPressed;

    if (currentValue == null) {
      onYesPressed = () => onPressed(true);
      onNoPressed = () => onPressed(false);
    } else if (currentValue) {
      onYesPressed = () => onPressed(null);
    } else {
      onNoPressed = () => onPressed(null);
    }

    return Row(
      children: [
        options.primaryButtonBuilder(
          context,
          text: inputField.yesLabel,
          onPressed: onYesPressed,
          onDisablePressed: () => onPressed(true),
          width: 250,
        ),
        const SizedBox(width: 32),
        options.primaryButtonBuilder(
          context,
          text: inputField.noLabel,
          onPressed: onNoPressed,
          onDisablePressed: () => onPressed(false),
          width: 250,
        ),
      ],
    );
  }
}
