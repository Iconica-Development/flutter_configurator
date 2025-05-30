import "package:flutter/material.dart";
import "package:flutter_configurator/flutter_configurator.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Flutter Configurator Example",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Configurator Demo"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Builder(
            builder: (context) => ConfiguratorUserstory(
              options: getConfiguratorOptions(context),
            ),
          ),
        ),
      );
}

ConfiguratorOptions getConfiguratorOptions(BuildContext context) =>
    ConfiguratorOptions(
      getAllConfigurationSteps: getAllConfigurationSteps,
      initialnode: initialNode,
      onConfiguratorLastStepReached: (values) async {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text("Configuration Saved"),
              content: SingleChildScrollView(child: Text("Data: $values")),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        });
      },
      nextButtonText: "Continue",
      configuratorColorOptions: const ConfiguratorColorOptions(
        activeStepsNodeColor: Colors.deepPurple,
        currentStepOutlineColor: Colors.purpleAccent,
        lineColor: Colors.grey,
        activeLineColor: Colors.deepPurple,
      ),
    );

// --- Step Keys ---
const String personalInfoStepKey = "personalInfo";
const String preferencesStepKey = "preferences";
const String advancedSettingsStepKey = "advancedSettings";
const String basicFeedbackStepKey = "basicFeedback";
const String contactDetailsStepKey = "contactDetails";
const String summaryAStepKey = "summaryA";
const String summaryBStepKey = "summaryB";

// --- Input Field Keys ---
const String nameInputKey = "name";
const String emailInputKey = "email";
const String enableAdvancedInputKey = "enableAdvanced";
const String advancedOptionInputKey = "advancedOption";
const String feedbackTextInputKey = "feedbackText";
const String contactPhoneInputKey = "contactPhone";
const String favoriteColorInputKey = "favoriteColor";

// --- Node Definitions ---

// Path A (Advanced Features Enabled) - 5 steps
final summaryNodeA = ConfiguratorNode(
  stepKey: summaryAStepKey,
  amountOfTotalSteps: (values) => 5,
);

final contactNodeA = ConfiguratorNode(
  stepKey: contactDetailsStepKey,
  nextStep: (values) => summaryNodeA,
  amountOfTotalSteps: (values) => 5,
);

final advancedSettingsNode = ConfiguratorNode(
  stepKey: advancedSettingsStepKey,
  nextStep: (values) => contactNodeA,
  amountOfTotalSteps: (values) => 5,
);

// Path B (Advanced Features Disabled) - 4 steps
final summaryNodeB = ConfiguratorNode(
  stepKey: summaryBStepKey,
  amountOfTotalSteps: (values) => 4,
);

final contactNodeB = ConfiguratorNode(
  stepKey: contactDetailsStepKey,
  nextStep: (values) => summaryNodeB,
  amountOfTotalSteps: (values) => 4,
);

final basicFeedbackNode = ConfiguratorNode(
  stepKey: basicFeedbackStepKey,
  nextStep: (values) => contactNodeB,
  amountOfTotalSteps: (values) => 4,
);

final preferencesNode = ConfiguratorNode(
  stepKey: preferencesStepKey,
  nextStep: (values) {
    bool advancedEnabled = values[enableAdvancedInputKey] ?? false;
    if (advancedEnabled) {
      return advancedSettingsNode;
    } else {
      return basicFeedbackNode;
    }
  },
  amountOfTotalSteps: (values) {
    bool advancedEnabled = values[enableAdvancedInputKey] ?? false;
    return advancedEnabled ? 5 : 4;
  },
);

final initialNode = ConfiguratorNode(
  stepKey: personalInfoStepKey,
  nextStep: (values) => preferencesNode,
  amountOfTotalSteps: (values) {
    bool advancedEnabled = values[enableAdvancedInputKey] ?? false;
    return values.containsKey(enableAdvancedInputKey)
        ? (advancedEnabled ? 5 : 4)
        : 4;
  },
);

// --- Step Definitions ---
Map<String, ConfiguratorStep> getAllConfigurationSteps(BuildContext context) =>
    {
      personalInfoStepKey: const ConfiguratorStep(
        title: "1. Personal Information",
        sections: [
          ConfiguratorSection(
            title: "About You",
            description: "Please enter your details below.",
            inputs: [
              ConfiguratorInputField(
                key: nameInputKey,
                label: "Full Name",
                hintText: "Enter your full name",
                isRequired: true,
              ),
              ConfiguratorInputField(
                key: emailInputKey,
                label: "Email Address",
                hintText: "Enter your email address",
                isRequired: true,
              ),
            ],
          ),
        ],
      ),
      preferencesStepKey: const ConfiguratorStep(
        title: "2. Your Preferences",
        sections: [
          ConfiguratorSection(
            title: "Feature Selection",
            inputs: [
              ConfiguratorInputDropdown(
                key: favoriteColorInputKey,
                label: "Primary Color Theme",
                hintText: "Select your primary color",
                options: ["Purple", "Green", "Orange"],
                isRequired: false,
              ),
              ConfiguratorYesNoButton(
                key: enableAdvancedInputKey,
                yesLabel: "Enable Advanced Features?",
                noLabel: "No, Keep it Simple",
                isRequired: true,
              ),
              ConfiguratorEmptySection(),
            ],
          ),
        ],
      ),
      // Path A Step
      advancedSettingsStepKey: const ConfiguratorStep(
        title: "3. Advanced Settings",
        sections: [
          ConfiguratorSection(
            title: "Customize Advanced Options",
            inputs: [
              ConfiguratorButtonSelection(
                key: advancedOptionInputKey,
                options: [
                  ConfiguratorButtonSelectionOption(
                    label: "Option X",
                    image: "",
                    value: "X",
                  ),
                  ConfiguratorButtonSelectionOption(
                    label: "Option Y",
                    image: "",
                    value: "Y",
                  ),
                  ConfiguratorButtonSelectionOption(
                    label: "Option Z",
                    image: "",
                    value: "Z",
                  ),
                ],
                isRequired: true,
              ),
            ],
          ),
        ],
      ),
      // Path B Step
      basicFeedbackStepKey: const ConfiguratorStep(
        title: "3. Basic Feedback",
        sections: [
          ConfiguratorSection(
            title: "Help Us Improve",
            description: "Why did you choose to keep it simple?",
            inputs: [
              ConfiguratorInputField(
                key: feedbackTextInputKey,
                label: "Your Feedback (Optional)",
                hintText: "Let us know your thoughts...",
                isRequired: false,
              ),
            ],
          ),
        ],
      ),
      // Reusable Contact Details Step Definition
      contactDetailsStepKey: const ConfiguratorStep(
        title: "Contact Information",
        sections: [
          ConfiguratorSection(
            title: "How can we reach you?",
            inputs: [
              ConfiguratorInputField(
                key: contactPhoneInputKey,
                label: "Phone Number",
                hintText: "Enter your phone number",
                isRequired: true,
              ),
            ],
          ),
        ],
      ),
      // Path A Summary
      summaryAStepKey: const ConfiguratorStep(
        title: "5. Summary (Advanced Path)",
        sections: [
          ConfiguratorSection(
            title: "Configuration Complete!",
            description: "Thank you for setting up advanced features. "
                "Review your choices.",
            inputs: [
              ConfiguratorEmptySection(),
            ],
          ),
        ],
      ),
      // Path B Summary
      summaryBStepKey: const ConfiguratorStep(
        title: "4. Summary (Basic Path)",
        sections: [
          ConfiguratorSection(
            title: "Configuration Complete!",
            description: "Thank you for completing the basic setup.",
            inputs: [
              ConfiguratorEmptySection(),
            ],
          ),
        ],
      ),
    };
