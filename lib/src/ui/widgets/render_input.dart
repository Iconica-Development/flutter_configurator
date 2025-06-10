import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/configurator_userstory.dart";

///
class RenderInput extends StatelessWidget {
  ///
  const RenderInput({
    required this.values,
    required this.onValueChanged,
    required this.input,
    this.inRowSection = false,
    super.key,
  });

  ///
  final Map<String, dynamic> values;

  ///
  final void Function(Map<String, dynamic> value) onValueChanged;

  ///
  final ConfiguratorInputType input;

  ///
  final bool inRowSection;

  @override
  Widget build(BuildContext context) {
    var options = ConfiguratorScope.of(context);

    void onInputChanged(String key, value) => onValueChanged({
          key: value,
        });

    return switch (input.runtimeType) {
      ConfiguratorButtonSelection =>
        options.inputBuilders.buttonSelectionBuilder(
          context,
          inputField: input as ConfiguratorButtonSelection,
          onPressed: (value) => onInputChanged(input.key, value),
          values: values,
        ),
      ConfiguratorFileUpload => options.inputBuilders.fileUploadButtonBuilder(
          context,
          inputField: input as ConfiguratorFileUpload,
          onPressed: () async {
            var maxSize = (input as ConfiguratorFileUpload).maxFileSize;
            var maxSizeInBytes = maxSize ?? 2 * 1024 * 1024;

            var result = await FilePicker.platform.pickFiles();
            if (result != null) {
              var file = result.files.first;
              if (file.size > maxSizeInBytes) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      content: Text(
                        // ignore: lines_longer_than_80_chars
                        "File size exceeds the limit of ${maxSizeInBytes / (1024 * 1024)} MB",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return;
              }

              onInputChanged(input.key, [file, ...?values[input.key]]);
            }
          },
          width: (input as ConfiguratorFileUpload).width,
          values: values,
          onDeletePressed: (value) {
            // remove item from the list
            onInputChanged(
              input.key,
              (values[input.key] as List<dynamic>)
                  .where((file) => file.name != value)
                  .toList(),
            );
          },
        ),
      ConfiguratorInputDropdown => options.inputBuilders.dropdownInputBuilder(
          context,
          inputField: input as ConfiguratorInputDropdown,
          values: values,
          onChanged: (value) => onInputChanged(input.key, value),
        ),
      ConfiguratorYesNoButton => options.inputBuilders.yesNoButtonBuilder(
          context,
          inputField: input as ConfiguratorYesNoButton,
          onPressed: (value) => onInputChanged(input.key, value),
          values: values,
        ),
      ConfiguratorInputField => options.inputBuilders.inputFieldBuilder(
          context,
          inputField: input as ConfiguratorInputField,
          onChanged: (value) => onInputChanged(input.key, value),
          initialValue: values[input.key] as String?,
          validationFunction: input.validator,
        ),
      ConfiguratorRowSection => options.inputBuilders.rowInputSectionBuilder(
          context,
          inputs: (input as ConfiguratorRowSection).inputs,
          values: values,
          onValueChanged: (value) => onInputChanged(value.$1, value.$2),
        ),
      ConfiguratorColumnSection =>
        options.inputBuilders.columnInputSectionBuilder(
          context,
          inputs: (input as ConfiguratorColumnSection).inputs,
          values: values,
          onValueChanged: (value) => onInputChanged(value.$1, value.$2),
        ),
      ConfiguratorImage => options.inputBuilders.imageBuilder(
          context,
          inputField: input as ConfiguratorImage,
          width: (input as ConfiguratorImage).width,
          scale: (input as ConfiguratorImage).scale,
          height: (input as ConfiguratorImage).height,
        ),
      ConfiguratorEmptySection => options.inputBuilders.emptyInputBuilder(
          context,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
