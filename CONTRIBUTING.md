# Contributing to Evently

First off, thank you for considering contributing to Evently! It's people like you that make Evently such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs** if possible
* **Include your Flutter version, Dart version, and OS**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior** and **explain which behavior you expected to see instead**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Do not include issue numbers in the PR title
* Follow the Dart/Flutter style guide
* Include screenshots and animated GIFs in your pull request whenever possible
* End all files with a newline
* Avoid platform-dependent code

## Development Setup

1. Fork the repo
2. Clone your fork
   ```bash
   git clone https://github.com/your-username/evently.git
   ```
3. Create a branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
4. Install dependencies
   ```bash
   flutter pub get
   ```
5. Make your changes
6. Run tests
   ```bash
   flutter test
   ```
7. Format your code
   ```bash
   flutter format .
   ```
8. Commit your changes
   ```bash
   git commit -m 'Add some amazing feature'
   ```
9. Push to your fork
   ```bash
   git push origin feature/amazing-feature
   ```
10. Open a Pull Request

## Style Guide

### Dart Style Guide

* Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
* Use `flutter format` before committing
* Keep lines under 80 characters when possible
* Use meaningful variable and function names
* Add comments for complex logic

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Flutter/Dart Specifics

* Use `const` constructors whenever possible
* Prefer `final` over `var` when the variable won't be reassigned
* Use named parameters for functions with multiple parameters
* Organize imports: dart SDK, flutter SDK, third-party packages, local imports
* Use trailing commas for better formatting

## Project Structure

```
lib/
├── core/               # Core functionality
│   ├── models/        # Data models
│   ├── providers/     # State management
│   ├── remote/        # API and database
│   └── resources/     # Assets and constants
└── ui/                # User interface
    ├── screens/       # App screens
    └── widgets/       # Reusable widgets
```

## Testing

* Write unit tests for new features
* Ensure all tests pass before submitting PR
* Aim for high code coverage
* Test on both Android and iOS when possible

## Documentation

* Update README.md if needed
* Add inline comments for complex logic
* Update CHANGELOG.md for significant changes
* Document public APIs

## Questions?

Feel free to open an issue with the tag `question` if you have any questions about contributing.

Thank you for contributing! 🎉
