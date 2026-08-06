import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/form_field_label.dart';

/// Groups a form field with an icon, title and optional subtitle.
///
/// Use to structure long forms into labelled sections. The icon is rendered in
/// a tinted rounded tile next to the [title] (with a required marker when
/// [isRequired] is true), followed by the [child] field.
///
/// Example:
/// ```dart
/// PRFFormSection(
///   icon: Icons.person_outline,
///   title: 'Contact details',
///   subtitle: 'How can the team reach you?',
///   isRequired: true,
///   child: PRFTextField(hintText: 'Full name', controller: _nameController),
/// )
/// ```
class PRFFormSection extends StatelessWidget {
  const PRFFormSection({
    required this.icon,
    required this.title,
    required this.child,
    super.key,
    this.isRequired = false,
    this.subtitle,
    this.margin,
  });

  /// Icon shown in the tinted tile next to the title.
  final IconData icon;

  /// Section heading.
  final String title;

  /// The form field(s) rendered below the heading.
  final Widget child;

  /// When true a required marker appears next to the title.
  final bool isRequired;

  /// Optional helper line rendered under the title.
  final String? subtitle;

  /// Outer margin; defaults to `EdgeInsets.only(bottom: PRFSpacingTokens.xl)`.
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: PRFSpacingTokens.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(PRFSpacingTokens.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: PRFSpacingTokens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PRFFormFieldLabel(label: title, isRequired: isRequired),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: PRFSpacingTokens.sm),
          child,
        ],
      ),
    );
  }
}
