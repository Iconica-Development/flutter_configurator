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
            var result = await FilePicker.platform.pickFiles();
            if (result != null) {
              var file = result.files.first;
              onInputChanged(input.key, file);
            }
          },
          width: (input as ConfiguratorFileUpload).width,
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
        ),
      ConfiguratorEmptySection => options.inputBuilders.emptyInputBuilder(
          context,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
