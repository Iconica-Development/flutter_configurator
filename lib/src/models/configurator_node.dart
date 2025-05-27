///
class ConfiguratorNode {
  ///
  const ConfiguratorNode({
    required this.stepKey,
    this.amountOfTotalSteps,
    this.nextStep,
  });

  ///
  final String stepKey;

  ///
  final int Function(Map<String, dynamic> values)? amountOfTotalSteps;

  ///
  final ConfiguratorNode Function(Map<String, dynamic> values)? nextStep;
}
