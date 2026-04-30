# Contributing to PRF Missions

Thank you for contributing to PRF Missions.

## Before You Start

- Read the [Code of Conduct](./CODE_OF_CONDUCT.md).
- Search existing issues before opening a new one.
- For setup support, email `engineering@parkroadfellowship.org`.

## Development Setup

1. Fork the repository.
2. Create a branch from the default branch:
   - `feature/<short-description>` or `fix/<short-description>`
3. Install dependencies:
   - `flutter pub get`

## Making Changes

- Keep pull requests focused on one concern.
- Follow existing naming and architecture conventions.
- Add or update tests for behavior changes.
- Run checks locally before pushing:
  - `dart format .`
  - `flutter analyze`
  - `flutter test`

## Commit Guidance

- Use clear commit messages in imperative style.
- Example: `Add mission engagement summary card`

## Pull Request Checklist

- Explain what changed and why.
- Link related issue(s) using `Closes #123` when applicable.
- Confirm tests pass locally.
- Include screenshots or recordings for UI changes where relevant.