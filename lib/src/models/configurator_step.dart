import "package:flutter/widgets.dart";
import "package:flutter_configurator/src/models/configurator_section.dart";

///
class ConfiguratorStep {
  ///
  const ConfiguratorStep({
    required this.title,
    required this.sections,
    this.validationFunction,
    this.backgroundWidget,
  });

  ///
  final String title;

  ///
  final List<ConfiguratorSection> sections;

  ///
  final ValidationFunction? validationFunction;

  ///
  final Widget? backgroundWidget;
}

///
typedef ValidationFunction = String? Function(Map<String, dynamic> values);
