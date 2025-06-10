import "package:flutter/material.dart";

///
class DefaultPrimaryButton extends StatelessWidget {
  ///
  const DefaultPrimaryButton({
    required this.text,
    required this.onPressed,
    this.onDisablePressed,
    this.onDeletePressed,
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
  final VoidCallback? onDeletePressed;

  ///
  final double? width;

  ///
  static Widget builder(
    BuildContext context, {
    required String text,
    required VoidCallback? onPressed,
    VoidCallback? onDisablePressed,
    VoidCallback? onDeletePressed,
    double? width,
  }) =>
      DefaultPrimaryButton(
        text: text,
        onPressed: onPressed,
        onDisablePressed: onDisablePressed,
        onDeletePressed: onDeletePressed,
        width: width ?? 200,
      );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onDisablePressed,
      child: FilledButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          fixedSize: WidgetStatePropertyAll(Size(width!, 50)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: onDeletePressed != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (onDeletePressed != null)
              const SizedBox(
                width: 24,
                height: 24,
              ),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: onDeletePressed != null
                    ? TextAlign.start
                    : TextAlign.center,
              ),
            ),
            if (onDeletePressed != null)
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 24,
                onPressed: onDeletePressed,
                icon: const Icon(Icons.close),
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
