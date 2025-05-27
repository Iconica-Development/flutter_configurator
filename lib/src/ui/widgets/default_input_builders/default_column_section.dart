import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/widgets/render_input.dart";

///
class DefaultColumnInputSection extends StatelessWidget {
  ///
  const DefaultColumnInputSection({
    required this.inputs,
    required this.values,
    required this.onValueChanged,
    super.key,
  });

  ///
  final List<ConfiguratorInputType> inputs;

  ///
  final Map<String, dynamic> values;

  ///
  final void Function((String key, dynamic value)) onValueChanged;

  ///
  static Widget builder(
    BuildContext context, {
    required List<ConfiguratorInputType> inputs,
    required Map<String, dynamic> values,
    required void Function((String key, dynamic value)) onValueChanged,
  }) =>
      DefaultColumnInputSection(
        inputs: inputs,
        values: values,
        onValueChanged: onValueChanged,
      );

  @override
  Widget build(BuildContext context) {
    void onInputChanged(String key, value) => onValueChanged((key, value));

    return Column(
      children: [
        for (var input in inputs) ...[
          if (inputs.indexOf(input) != 0) ...[
            const SizedBox(
              height: 32,
            ),
          ],
          RenderInput(
            values: values,
            input: input,
            onValueChanged: (value) => onInputChanged(
              value.entries.first.key,
              value.entries.first.value,
            ),
          ),
        ],
      ],
    );
  }
}
