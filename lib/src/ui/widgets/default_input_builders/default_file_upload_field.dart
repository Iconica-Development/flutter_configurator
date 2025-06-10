import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/configurator_userstory.dart";

///
class DefaultFileUploadButton extends StatelessWidget {
  ///
  const DefaultFileUploadButton({
    required this.inputField,
    required this.onPressed,
    required this.values,
    this.onDeletePressed,
    this.maxFileSize,
    super.key,
  });

  ///
  final ConfiguratorFileUpload inputField;

  ///
  final VoidCallback onPressed;

  ///
  final Map<String, dynamic> values;

  ///
  final Function(String name)? onDeletePressed;

  ///
  final double? maxFileSize;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorFileUpload inputField,
    required VoidCallback onPressed,
    required Map<String, dynamic> values,
    Function(String name)? onDeletePressed,
    double? width,
    double? maxFileSize,
  }) =>
      DefaultFileUploadButton(
        inputField: inputField,
        onPressed: onPressed,
        values: values,
        onDeletePressed: onDeletePressed,
        maxFileSize: maxFileSize,
      );

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);
    var inputValues = values[inputField.key];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (inputValues != null) ...[
          for (var file in inputValues) ...[
            options.primaryButtonBuilder(
              context,
              text: "${file.name}",
              onPressed: onPressed,
              width: inputField.width,
              onDisablePressed: onPressed,
              onDeletePressed: onDeletePressed != null
                  ? () => onDeletePressed!(file.name)
                  : null,
            ),
          ],
        ],
        if (inputValues == null || (inputValues as List).isEmpty) ...[
          options.primaryButtonBuilder(
            context,
            text: inputField.buttonText,
            onPressed: onPressed,
            width: inputField.width,
          ),
        ] else ...[
          ElevatedButton(
            onPressed: onPressed,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xffD9D9D9)),
              elevation: WidgetStatePropertyAll(0),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              fixedSize: WidgetStatePropertyAll(Size(50, 50)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFFEE642D),
              size: 28,
            ),
          ),
        ],
      ],
    );
  }
}
