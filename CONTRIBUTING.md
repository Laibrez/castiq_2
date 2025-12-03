# Contributing to Castiq

Thank you for your interest in contributing to Castiq! This guide will help you get started.

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio or VS Code
- Git

### Setup
1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/castiq_2.git
   cd castiq_2
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/Laibrez/castiq_2.git
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```

## Development Workflow

### 1. Create a Feature Branch
```bash
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes
- Follow the existing code style
- Write clear, descriptive commit messages
- Keep commits focused and atomic
- Test your changes thoroughly

### 3. Code Style Guidelines

#### Dart/Flutter
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format .` to format your code
- Run `flutter analyze` to check for issues
- Use meaningful variable and function names
- Add comments for complex logic

#### File Organization
```
lib/
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── services/        # API services, utilities
├── theme/           # Theme configuration
└── utils/           # Helper functions
```

#### Widget Structure
```dart
class MyWidget extends StatelessWidget {
  // Constants at the top
  static const double padding = 16.0;
  
  // Required parameters
  final String title;
  
  // Optional parameters
  final VoidCallback? onTap;
  
  // Constructor
  const MyWidget({
    super.key,
    required this.title,
    this.onTap,
  });
  
  // Build method
  @override
  Widget build(BuildContext context) {
    // Implementation
  }
  
  // Helper methods (if any)
  Widget _buildSomething() {
    // Implementation
  }
}
```

### 4. Testing

Run tests before committing:
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### 5. Commit Your Changes

Use clear commit messages:
```bash
git commit -m "Add: Feature description"
git commit -m "Fix: Bug description"
git commit -m "Update: Change description"
git commit -m "Refactor: Refactoring description"
```

### 6. Push and Create Pull Request
```bash
git push origin feature/your-feature-name
```

Then create a pull request on GitHub.

## Pull Request Guidelines

### PR Title Format
- `[Feature] Brief description`
- `[Fix] Brief description`
- `[Update] Brief description`
- `[Refactor] Brief description`

### PR Description Should Include
1. **What**: What changes were made
2. **Why**: Why these changes were necessary
3. **How**: How the changes work
4. **Testing**: How the changes were tested
5. **Screenshots**: For UI changes

### Example PR Description
```markdown
## What
Added dark mode toggle to settings screen

## Why
Users requested ability to switch between light and dark themes

## How
- Created theme provider to manage theme state
- Added toggle switch in settings
- Persisted preference using SharedPreferences

## Testing
- Tested on Android and iOS
- Verified theme persists after app restart
- Checked all screens in both themes

## Screenshots
[Attach screenshots here]
```

## Code Review Process

1. All PRs require at least one approval
2. Address all review comments
3. Keep PRs focused and reasonably sized
4. Update your PR if main branch has changed:
   ```bash
   git fetch upstream
   git rebase upstream/main
   git push origin feature/your-feature-name --force
   ```

## Types of Contributions

### Bug Fixes
- Fix existing issues
- Add tests to prevent regression
- Document the fix in PR description

### New Features
- Discuss feature in an issue first
- Follow existing patterns and architecture
- Add tests for new functionality
- Update documentation

### Documentation
- Fix typos and improve clarity
- Add examples and usage instructions
- Keep documentation up-to-date with code

### Performance Improvements
- Provide benchmarks showing improvement
- Ensure no functionality is broken
- Document the optimization technique

## Reporting Bugs

### Before Reporting
1. Check existing issues
2. Verify it's reproducible
3. Test on latest version

### Bug Report Should Include
- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: 
  - Flutter version
  - Device/emulator
  - OS version
- **Screenshots/Videos**: If applicable
- **Logs**: Error messages or stack traces

## Suggesting Features

### Feature Request Should Include
- **Problem**: What problem does it solve
- **Solution**: Proposed solution
- **Alternatives**: Other solutions considered
- **Examples**: How other apps handle this
- **Benefits**: Why this would be valuable

## Project-Specific Guidelines

### State Management
- Use Provider for state management
- Keep providers focused and single-purpose
- Avoid business logic in widgets

### API Integration
- All API calls go in service classes
- Handle errors gracefully
- Provide loading states
- Cache when appropriate

### UI/UX
- Follow black and white theme
- Maintain consistency across screens
- Provide feedback for user actions
- Handle loading and error states
- Support both light and dark modes

### Security
- Never commit sensitive data
- Validate all user inputs
- Use secure storage for sensitive data
- Follow security best practices

## Questions?

If you have questions:
1. Check existing documentation
2. Search closed issues
3. Ask in a new issue
4. Contact maintainers

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

---

Thank you for contributing to Castiq! 🎉
