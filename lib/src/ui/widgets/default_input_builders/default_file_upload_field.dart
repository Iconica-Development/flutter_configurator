import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/configurator_userstory.dart";

///
class DefaultFileUploadButton extends StatelessWidget {
  ///
  const DefaultFileUploadButton({
    required this.inputField,
    required this.onPressed,
    super.key,
  });

  ///
  final ConfiguratorFileUpload inputField;

  ///
  final VoidCallback onPressed;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorFileUpload inputField,
    required VoidCallback onPressed,
    double? width,
  }) =>
      DefaultFileUploadButton(
        inputField: inputField,
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    return options.primaryButtonBuilder(
      context,
      text: inputField.buttonText,
      onPressed: onPressed,
      width: inputField.width,
    );
  }
}
