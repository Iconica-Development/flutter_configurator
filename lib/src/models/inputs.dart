import "package:flutter/widgets.dart";

///
abstract class ConfiguratorInputType {
  ///
  const ConfiguratorInputType({
    required this.key,
    required this.isRequired,
    this.validationFunction,
  });

  ///
  final String key;

  ///
  final bool isRequired;

  ///
  final String? Function(Map<String, dynamic>)? validationFunction;

  ///
  String? Function(Map<String, dynamic>) get validator =>
      validationFunction ?? defaultValidation;

  ///
  String? defaultValidation(Map<String, dynamic> values);
}

///
class ConfiguratorFileUpload extends ConfiguratorInputType {
  ///
  const ConfiguratorFileUpload({
    required super.key,
    required this.buttonText,
    this.width,
    super.isRequired = true,
    super.validationFunction,
  });

  ///
  final String buttonText;

  ///
  final double? width;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    if (!isRequired) return null;
    var value = values[key];
    if (value == null) {
      return "Please upload a file for $key";
    }
    return null;
  }
}

///
class ConfiguratorInputField extends ConfiguratorInputType {
  ///
  const ConfiguratorInputField({
    required super.key,
    required this.label,
    required this.hintText,
    super.isRequired = true,
    super.validationFunction,
  });

  ///
  final String label;

  ///
  final String hintText;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    if (!isRequired) return null;
    var value = values[key];
    if (value == null || (value is String && value.trim().isEmpty)) {
      return "Please fill in the field for $key";
    }
    return null;
  }
}

///
class ConfiguratorInputDropdown extends ConfiguratorInputType {
  ///
  const ConfiguratorInputDropdown({
    required super.key,
    required this.label,
    required this.hintText,
    required this.options,
    super.isRequired = true,
    super.validationFunction,
  });

  ///
  final String label;

  ///
  final String hintText;

  ///
  final List<String> options;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    if (!isRequired) return null;
    var value = values[key];
    if (value == null) {
      return "Please select an option for $key";
    }
    return null;
  }
}

///
class ConfiguratorButtonSelection extends ConfiguratorInputType {
  ///
  const ConfiguratorButtonSelection({
    required super.key,
    required this.options,
    super.isRequired = true,
    super.validationFunction,
  });

  ///
  final List<ConfiguratorButtonSelectionOption> options;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    if (!isRequired) return null;
    var value = values[key];
    if (value == null) {
      return "Please select an option for $key";
    }
    return null;
  }
}

///
class ConfiguratorButtonSelectionOption {
  ///
  const ConfiguratorButtonSelectionOption({
    required this.label,
    required this.image,
    required this.value,
    this.padding,
  });

  ///
  final String label;

  ///
  final String image;

  ///
  final String value;

  /// padding for the content inside the button. If null, no padding is applied.
  final EdgeInsetsGeometry? padding;
}

///
class ConfiguratorYesNoButton extends ConfiguratorInputType {
  ///
  const ConfiguratorYesNoButton({
    required super.key,
    required this.yesLabel,
    required this.noLabel,
    super.isRequired = true,
    super.validationFunction,
  });

  ///
  final String yesLabel;

  ///
  final String noLabel;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    if (!isRequired) return null;
    var value = values[key];
    if (value == null) {
      return "Please select yes or no for $key";
    }
    return null;
  }
}

///
class ConfiguratorRowSection extends ConfiguratorInputType {
  ///
  const ConfiguratorRowSection({
    required this.inputs,
  }) : super(key: "", isRequired: true);

  ///
  final List<ConfiguratorInputType> inputs;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    for (var input in inputs) {
      var msg = input.validator(values);
      if (msg != null) return msg;
    }
    return null;
  }
}

///
class ConfiguratorColumnSection extends ConfiguratorInputType {
  ///
  const ConfiguratorColumnSection({
    required this.inputs,
  }) : super(key: "", isRequired: true);

  ///
  final List<ConfiguratorInputType> inputs;

  @override
  String? defaultValidation(Map<String, dynamic> values) {
    for (var input in inputs) {
      var msg = input.validator(values);
      if (msg != null) return msg;
    }
    return null;
  }
}

///
class ConfiguratorImage extends ConfiguratorInputType {
  ///
  const ConfiguratorImage({
    required this.imagePath,
    this.width,
    this.scale,
  }) : super(key: "", isRequired: false);

  ///
  final String imagePath;

  ///
  final double? width;

  ///
  final double? scale;

  @override
  String? defaultValidation(Map<String, dynamic> values) => null;
}

/// This input type is used to create an empty section in the configuration.
/// This can be useful for layout spacing
class ConfiguratorEmptySection extends ConfiguratorInputType {
  /// Constructor for an empty section.
  const ConfiguratorEmptySection() : super(key: "", isRequired: true);

  @override
  String? defaultValidation(Map<String, dynamic> values) => null;
}
