import "package:flutter_configurator/src/models/configurator_step.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class ConfiguratorSection {
  ///
  const ConfiguratorSection({
    required this.title,
    required this.inputs,
    this.description,
    this.image,
    this.validationFunction,
  });

  ///
  final String title;

  ///
  final String? description;

  ///
  final String? image;

  ///
  final List<ConfiguratorInputType> inputs;

  ///
  final ValidationFunction? validationFunction;
}
