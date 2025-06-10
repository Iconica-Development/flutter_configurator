import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class DefaultTextInputField extends StatefulWidget {
  ///
  const DefaultTextInputField({
    required this.inputField,
    required this.onChanged,
    required this.initialValue,
    required this.validationFunction,
    super.key,
  });

  ///
  final ConfiguratorInputField inputField;

  ///
  final void Function(String value) onChanged;

  ///
  final String? initialValue;

  /// The validation message to show when the input is invalid.
  final String? Function(Map<String, dynamic>) validationFunction;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorInputField inputField,
    required void Function(String value) onChanged,
    required String? initialValue,
    required String? Function(Map<String, dynamic>) validationFunction,
  }) =>
      DefaultTextInputField(
        inputField: inputField,
        onChanged: onChanged,
        initialValue: initialValue,
        validationFunction: validationFunction,
      );

  @override
  State<DefaultTextInputField> createState() => _DefaultTextInputFieldState();
}

class _DefaultTextInputFieldState extends State<DefaultTextInputField> {
  final inputKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputField.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 600,
              child: TextFormField(
                key: inputKey,
                initialValue: widget.initialValue,
                onChanged: (value) {
                  inputKey.currentState?.validate();
                  widget.onChanged.call(value);
                },
                decoration: InputDecoration(
                  hintText: widget.inputField.hintText,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) => widget.validationFunction({
                  widget.inputField.key: value,
                }),
              ),
            ),
          ),
        ],
      );
}
