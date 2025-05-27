import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class DefaultTextInputField extends StatelessWidget {
  ///
  const DefaultTextInputField({
    required this.inputField,
    required this.onChanged,
    required this.initialValue,
    super.key,
  });

  ///
  final ConfiguratorInputField inputField;

  ///
  final void Function(String value) onChanged;

  ///
  final String? initialValue;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorInputField inputField,
    required void Function(String value) onChanged,
    required String? initialValue,
  }) =>
      DefaultTextInputField(
        inputField: inputField,
        onChanged: onChanged,
        initialValue: initialValue,
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputField.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: inputField.hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
        ],
      );
}
