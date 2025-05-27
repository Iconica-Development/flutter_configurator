import "package:flutter/widgets.dart";

/// A widget that can be used to fill up space.
class DefaultEmptyInputSection extends StatelessWidget {
  /// Creates a widget that fills up space without rendering anything.
  const DefaultEmptyInputSection({super.key});

  /// A static builder method that returns an instance
  /// of [DefaultEmptyInputSection].
  static Widget builder(
    BuildContext context,
  ) =>
      const DefaultEmptyInputSection();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
