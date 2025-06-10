import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/inputs.dart";

///
class DefaultImage extends StatelessWidget {
  ///
  const DefaultImage({
    required this.inputField,
    this.width,
    this.height,
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
  final double? height;

  ///
  static Widget builder(
    BuildContext context, {
    required ConfiguratorImage inputField,
    double? scale,
    double? width,
    double? height,
  }) =>
      DefaultImage(
        inputField: inputField,
        width: width,
        height: height,
        scale: scale ?? 0.1,
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var defaultWidth = size.width * 0.45;
    var defaultHeight = size.height * 0.40;
    return Image.asset(
      fit: BoxFit.cover,
      inputField.imagePath,
      width: width ?? defaultWidth,
      scale: scale,
      height: height ?? defaultHeight,
    );
  }
}
