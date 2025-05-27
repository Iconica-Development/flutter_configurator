import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/configurator_step.dart";
import "package:flutter_configurator/src/ui/widgets/configuration_section.dart";

///
class ConfiguratorStepDisplay extends StatelessWidget {
  ///
  const ConfiguratorStepDisplay({
    required this.step,
    required this.values,
    required this.onValueChanged,
    required this.onpressBack,
    required this.isLastStep,
    super.key,
  });

  ///
  final ConfiguratorStep step;

  ///
  final Map<String, dynamic> values;

  ///
  final void Function(Map<String, dynamic> value) onValueChanged;

  ///
  final VoidCallback onpressBack;

  ///
  final bool isLastStep;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!isLastStep) ...[
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                  onPressed: onpressBack,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  step.title,
                  style: textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          for (var section in step.sections) ...[
            const SizedBox(height: 40),
            ConfigurationStepSection(
              section: section,
              values: values,
              onValueChanged: onValueChanged,
            ),
          ],
        ],
      ),
    );
  }
}
