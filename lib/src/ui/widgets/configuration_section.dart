import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/configurator_section.dart";
import "package:flutter_configurator/src/ui/widgets/render_input.dart";
import "package:flutter_hooks/flutter_hooks.dart";

///
class ConfigurationStepSection extends HookWidget {
  ///
  const ConfigurationStepSection({
    required this.section,
    required this.values,
    required this.onValueChanged,
    super.key,
  });

  ///
  final ConfiguratorSection section;

  ///
  final Map<String, dynamic> values;

  ///
  final void Function(Map<String, dynamic> value) onValueChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: theme.textTheme.titleLarge,
        ),
        if (section.description != null) ...[
          const SizedBox(height: 20),
          Text(
            section.description!,
            style: textTheme.bodyLarge,
          ),
        ],
        for (var input in section.inputs) ...[
          const SizedBox(
            height: 32,
          ),
          RenderInput(
            values: values,
            onValueChanged: onValueChanged,
            input: input,
          ),
        ],
      ],
    );
  }
}
