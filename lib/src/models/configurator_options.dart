import "package:flutter/material.dart";
import "package:flutter_configurator/src/models/configurator_node.dart";
import "package:flutter_configurator/src/models/configurator_step.dart";
import "package:flutter_configurator/src/models/inputs.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_button_selection.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_column_section.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_dropdown_input.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_empty_input.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_file_upload_field.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_image_builder.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_primary_button_builder.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_row_section.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_text_input_field.dart";
import "package:flutter_configurator/src/ui/widgets/default_input_builders/default_yes_no_button.dart";

///
class ConfiguratorOptions {
  /// Creates a new instance of [ConfiguratorOptions].
  const ConfiguratorOptions({
    required this.getAllConfigurationSteps,
    required this.initialnode,
    this.onConfiguratorLastStepReached,
    this.configuratorColorOptions = const ConfiguratorColorOptions(),
    this.inputBuilders = const ConfiguratorInputBuilders(),
    this.nextButtonText = "Next",
    this.contentPadding,
    this.nextButtonPadding,
    this.primaryButtonBuilder = DefaultPrimaryButton.builder,
  });

  ///
  final ConfiguratorInputBuilders inputBuilders;

  ///
  final ConfiguratorStepBuilder getAllConfigurationSteps;

  ///
  final ConfiguratorNode initialnode;

  /// Padding around the content of the configurator steps
  final EdgeInsets? contentPadding;

  /// Padding around the next button
  final EdgeInsets? nextButtonPadding;

  /// The text for the next button to go to the next step in the configurator.
  final String nextButtonText;

  /// Color options for the configurator. If not provided the values will
  /// default to colors from the app's [ThemeData].
  final ConfiguratorColorOptions configuratorColorOptions;

  /// Triggered when the final configurator step is reached.
  /// This is useful for saving the configuration or performing
  /// any other final actions.
  final ConfiguratorFinishCallback? onConfiguratorLastStepReached;

  /// The builder for the primary button
  final PrimaryButtonBuilder primaryButtonBuilder;
}

///
class ConfiguratorColorOptions {
  ///
  const ConfiguratorColorOptions({
    this.activeLineColor,
    this.lineColor,
    this.nextStepsNodeColor,
    this.activeStepsNodeColor,
    this.currentStepOutlineColor,
    this.finalStepNodeColor,
  });

  /// The color of the line connecting all the previous steps to the current
  /// step.
  final Color? activeLineColor;

  /// The color of the line connecting the current step with the next steps.
  final Color? lineColor;

  /// The color of the nodes that are in the next steps except the final step.
  final Color? nextStepsNodeColor;

  /// The color of the node for the current and previous steps.
  final Color? activeStepsNodeColor;

  /// The color of the circle outline for the current step.
  final Color? currentStepOutlineColor;

  /// The color of the node for the final step.
  final Color? finalStepNodeColor;
}

///
class ConfiguratorInputBuilders {
  ///
  const ConfiguratorInputBuilders({
    this.inputFieldBuilder = DefaultTextInputField.builder,
    this.fileUploadButtonBuilder = DefaultFileUploadButton.builder,
    this.dropdownInputBuilder = DefaultDropdownInput.builder,
    this.buttonSelectionBuilder = DefaultButtonSelection.builder,
    this.yesNoButtonBuilder = DefaultYesNoButton.builder,
    this.rowInputSectionBuilder = DefaultRowInputSection.builder,
    this.columnInputSectionBuilder = DefaultColumnInputSection.builder,
    this.imageBuilder = DefaultImage.builder,
    this.emptyInputBuilder = DefaultEmptyInputSection.builder,
  });

  ///
  final InputFieldBuilder inputFieldBuilder;

  ///
  final FileUploadButtonBuilder fileUploadButtonBuilder;

  ///
  final DropdownInputBuilder dropdownInputBuilder;

  ///
  final ButtonSelectionBuilder buttonSelectionBuilder;

  ///
  final YesNoButtonBuilder yesNoButtonBuilder;

  ///
  final CombinedInputSectionBuilder rowInputSectionBuilder;

  ///
  final CombinedInputSectionBuilder columnInputSectionBuilder;

  ///
  final ImageBuilder imageBuilder;

  /// A builder for an empty input section, used for spacing in the configurator
  final EmptyInputSectionBuilder emptyInputBuilder;
}

///
typedef ConfiguratorFinishCallback = void Function(
  Map<String, dynamic> values,
);

/// A function that returns a map of [ConfiguratorStep]s.
/// The [context] is used to access localization and other
/// context-specific information.
typedef ConfiguratorStepBuilder = Map<String, ConfiguratorStep> Function(
  BuildContext context,
);

///
typedef InputFieldBuilder = Widget Function(
  BuildContext context, {
  required ConfiguratorInputField inputField,
  required void Function(String value) onChanged,
  required String? initialValue,
  required String? Function(Map<String, dynamic>) validationFunction,
});

///
typedef FileUploadButtonBuilder = Widget Function(
  BuildContext context, {
  required ConfiguratorFileUpload inputField,
  required VoidCallback onPressed,
  required Map<String, dynamic> values,
  double? maxFileSize,
  void Function(String name)? onDeletePressed,
  double? width,
});

///
typedef DropdownInputBuilder<T> = Widget Function(
  BuildContext context, {
  required ConfiguratorInputDropdown inputField,
  required Function(T? value) onChanged,
  required Map<String, dynamic> values,
});

///
typedef ButtonSelectionBuilder = Widget Function(
  BuildContext context, {
  required ConfiguratorButtonSelection inputField,
  required void Function(String value) onPressed,
  required Map<String, dynamic> values,
});

///
typedef YesNoButtonBuilder = Widget Function(
  BuildContext context, {
  required ConfiguratorYesNoButton inputField,
  required ValueChanged<bool?> onPressed,
  required Map<String, dynamic> values,
});

/// Builder for a column or row of inputs.
typedef CombinedInputSectionBuilder = Widget Function(
  BuildContext context, {
  required List<ConfiguratorInputType> inputs,
  required Map<String, dynamic> values,
  required void Function((String, dynamic)) onValueChanged,
});

///
typedef ImageBuilder = Widget Function(
  BuildContext context, {
  required ConfiguratorImage inputField,
  double? width,
  double? scale,
});

///
typedef PrimaryButtonBuilder = Widget Function(
  BuildContext context, {
  required String text,
  required VoidCallback? onPressed,
  VoidCallback? onDisablePressed,
  VoidCallback? onDeletePressed,
  double? width,
});

///
typedef EmptyInputSectionBuilder = Widget Function(
  BuildContext context,
);
