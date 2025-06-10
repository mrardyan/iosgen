# __PROJECT_NAME__
<!-- Add __PROJECT_NAME__ description here -->

## Features
<!-- Add __PROJECT_NAME__ features here -->

## Requirements
<!-- Add __PROJECT_NAME__ requirements here -->

## Getting Started

To set up the project, run the following script:

```bash
sh ./Scripts/setup.sh
```

This will install all necessary dependencies and configure the environment to start building the project using Tuist.

## Tuist Commands
To learn more about Tuist and its commands, visit the [Tuist Quick Start Guide](https://docs.tuist.io/guides/quick-start/install-tuist).

### Generate the Xcode Project
To generate the Xcode project, you can use Tuist's `generate` command. This will create the necessary `.xcodeproj` file based on the project's `Tuist` configuration.

```bash
tuist generate
```

### Edit the Project Configuration
If you need to modify the Tuist project configuration (for example, to change dependencies, targets, or settings), you can use the edit command to open the project configuration in Xcode.

```bash
tuist edit
```

This command opens the Tuist project as an Xcode project, allowing you to easily edit the configuration.

## Project Structure
- **App**: Contains the main source code for the application.
  This is where all the development for the app is done.
- **Tuist**: Contains configuration files for Tuist. Managed by Tuist.
- **Scripts**: Contains build scripts for setup and other configurations.
- **.XcodeFileTemplates**: Contains custom Xcode file templates for generating project files.