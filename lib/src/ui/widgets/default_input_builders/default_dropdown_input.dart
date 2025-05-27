import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class DefaultDropdownInput<T> extends StatelessWidget {
  ///
  const DefaultDropdownInput({
    required this.inputField,
    required this.onChanged,
    required this.values,
    super.key,
  });

  ///
  final ConfiguratorInputDropdown inputField;

  ///
  final void Function(T? value) onChanged;

  ///
  final Map<String, dynamic> values;

  ///
  static Widget builder<T>(
    BuildContext context, {
    required ConfiguratorInputDropdown inputField,
    required void Function(T? value) onChanged,
    required Map<String, dynamic> values,
  }) =>
      DefaultDropdownInput(
        inputField: inputField,
        onChanged: onChanged,
        values: values,
      );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var selectedValue = values[inputField.key] as T?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          inputField.label,
          style: textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<T?>(
          value: selectedValue,
          borderRadius: BorderRadius.circular(12),
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
          items: inputField.options.map(
            (option) {
              var value = option as T?;
              return DropdownMenuItem<T?>(
                value: value,
                child: Text(value.toString()),
              );
            },
          ).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
