import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class DefaultImage extends StatelessWidget {
  ///
  const DefaultImage({
    required this.inputField,
    this.width,
    this.scale,
    super.key,
  });

  ///
  final ConfiguratorImage inputField;

  ///
  final double? width;

  ///
  final double? scale;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorImage inputField,
    double? scale,
    double? width,
  }) =>
      DefaultImage(
        inputField: inputField,
        width: width,
        scale: scale ?? 0.1,
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var defaultWidth = size.width * 0.45;
    return Image.asset(
      inputField.imagePath,
      width: width ?? defaultWidth,
      scale: scale,
    );
  }
}
