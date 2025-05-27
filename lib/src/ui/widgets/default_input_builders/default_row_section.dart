import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/widgets/render_input.dart";

///
class DefaultRowInputSection extends StatelessWidget {
  ///
  const DefaultRowInputSection({
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
      DefaultRowInputSection(
        inputs: inputs,
        values: values,
        onValueChanged: onValueChanged,
      );

  @override
  Widget build(BuildContext context) {
    void onInputChanged(String key, value) => onValueChanged((key, value));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var input in inputs) ...[
          Expanded(
            child: RenderInput(
              inRowSection: true,
              values: values,
              input: input,
              onValueChanged: (value) => onInputChanged(
                value.entries.first.key,
                value.entries.first.value,
              ),
            ),
          ),
          if (inputs.indexOf(input) != inputs.length - 1) ...[
            const SizedBox(
              width: 32,
            ),
          ],
        ],
      ],
    );
  }
}
