import "package:flutter/material.dart";

///
class DefaultPrimaryButton extends StatelessWidget {
  ///
  const DefaultPrimaryButton({
    required this.text,
    required this.onPressed,
    this.onDisablePressed,
    this.width = 200,
    super.key,
  });

  ///
  final String text;

  /// If this is null, the button will look disabled
  final VoidCallback? onPressed;

  /// Using this callback keeps the button looking disabled
  final VoidCallback? onDisablePressed;

  ///
  final double? width;

  ///
  static Widget builder(
    BuildContext context, {
    required String text,
    required VoidCallback? onPressed,
    VoidCallback? onDisablePressed,
    double? width,
  }) =>
      DefaultPrimaryButton(
        text: text,
        onPressed: onPressed,
        onDisablePressed: onDisablePressed,
        width: width ?? 200,
      );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onDisablePressed,
      child: FilledButton(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(width!, 50)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: theme.textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
