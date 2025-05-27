import "package:flutter_configurator/src/models/configurator_section.dart";

///
class ConfiguratorStep {
  ///
  const ConfiguratorStep({
    required this.title,
    required this.sections,
    this.validationFunction,
  });

  ///
  final String title;

  ///
  final List<ConfiguratorSection> sections;

  ///
  final ValidationFunction? validationFunction;
}

///
typedef ValidationFunction = String? Function(Map<String, dynamic> values);
