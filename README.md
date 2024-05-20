Create a Flutter application that:

Supports both Android and iOS platforms seamlessly.
Adapts to light and dark themes based on the system's theme settings.
Allows users to manage (view, edit) person details including name, phone number, chat conversation, image, date, and time.
Features:

Cross-Platform Support:

Utilize platform-specific widgets to ensure native look and feel on both Android and iOS devices.
Use Material design components for Android and Cupertino design components for iOS.
Theming:

Implement light and dark themes that automatically switch based on the device's system settings.
Ensure that the UI elements are properly styled for both themes to maintain a consistent user experience.
Person Details Management:

Allow users to view a list of persons with details such as name, phone number, chat conversation, image, date, and time.
Provide functionality to edit these details with platform-specific dialogs.
Enable image selection through camera or gallery.
Implement date and time pickers that adhere to the design guidelines of each platform.
Technical Approach:

Project Setup:

Configure dependencies in pubspec.yaml for essential packages like cupertino_icons and intl for date formatting.
Main Application:

Use MaterialApp for Android and CupertinoApp for iOS with a unified entry point.
Set up theming using ThemeData for light and dark themes in the MaterialApp.
Platform-Specific Widgets:

Create separate widgets and dialogs for editing person details tailored to Android and iOS.
Use conditional rendering to switch between Material and Cupertino components based on the platform.
State Management:

Implement state management to handle person details and form inputs using providers or stateful widgets.
UI Components:

Develop reusable UI components for person detail fields (name, phone number, etc.).
Ensure accessibility and responsiveness across different device sizes.
