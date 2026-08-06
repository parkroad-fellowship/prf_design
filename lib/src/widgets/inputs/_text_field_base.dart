import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prf_design/src/widgets/inputs/_capitalization.dart';
import 'package:prf_design/src/widgets/inputs/prf_text_field.dart';

/// Shared implementation behind [PRFTextField].
class PRFTextFieldBase extends StatefulWidget {
  const PRFTextFieldBase({
    required this.hintText,
    required this.controller,
    required this.type,
    required this.enabled,
    required this.readOnly,
    required this.onChanged,
    required this.labelText,
    required this.errorText,
    required this.helperText,
    required this.keyboardType,
    required this.textInputAction,
    required this.normalizeLeadingCapitalization,
    required this.isLoading,
    required this.prefixText,
    required this.minLines,
    required this.maxLines,
    required this.autocorrect,
    this.obscureNotifier,
    this.initiallyHidden = true,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final PRFTextFieldType type;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool normalizeLeadingCapitalization;
  final bool isLoading;
  final String? prefixText;
  final int? minLines;
  final int? maxLines;
  final bool? autocorrect;

  /// Optional external visibility control for password inputs. When provided,
  /// the visibility toggle writes here instead of local state.
  final ValueNotifier<bool>? obscureNotifier;
  final bool initiallyHidden;

  @override
  State<PRFTextFieldBase> createState() => _PRFTextFieldBaseState();
}

class _PRFTextFieldBaseState extends State<PRFTextFieldBase> {
  late bool _hidden = widget.initiallyHidden;

  bool get _isPassword => widget.type == PRFTextFieldType.password;

  bool get _obscure => widget.obscureNotifier?.value ?? _hidden;

  bool get _isEnabled => widget.enabled && !widget.isLoading;

  void _toggleVisibility() {
    final notifier = widget.obscureNotifier;
    if (notifier != null) {
      notifier.value = !notifier.value;
    } else {
      setState(() => _hidden = !_hidden);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      label: widget.hintText,
      textField: true,
      enabled: _isEnabled,
      child: TextFormField(
        controller: widget.controller,
        enabled: _isEnabled,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType ?? _keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: _capitalization,
        obscureText: _isPassword && _obscure,
        autocorrect: widget.autocorrect ?? true,
        inputFormatters: _inputFormatters,
        minLines: widget.minLines,
        maxLines: _isPassword ? 1 : widget.maxLines,
        style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixText: widget.type == PRFTextFieldType.number
              ? widget.prefixText
              : null,
          prefixIcon: _prefixIcon,
          alignLabelWithHint: widget.type == PRFTextFieldType.textArea,
          suffixIcon: _isPassword ? _visibilityToggle : null,
        ),
      ),
    );
  }

  TextInputType get _keyboardType => switch (widget.type) {
    PRFTextFieldType.text => TextInputType.text,
    PRFTextFieldType.email => TextInputType.emailAddress,
    PRFTextFieldType.name => TextInputType.name,
    PRFTextFieldType.number => TextInputType.number,
    PRFTextFieldType.password => TextInputType.visiblePassword,
    PRFTextFieldType.textArea => TextInputType.multiline,
  };

  TextCapitalization get _capitalization => switch (widget.type) {
    PRFTextFieldType.name => TextCapitalization.words,
    PRFTextFieldType.textArea => TextCapitalization.sentences,
    _ => TextCapitalization.none,
  };

  List<TextInputFormatter> get _inputFormatters => [
    if (widget.type == PRFTextFieldType.number)
      FilteringTextInputFormatter.digitsOnly,
    if (widget.normalizeLeadingCapitalization &&
        widget.type != PRFTextFieldType.number &&
        widget.type != PRFTextFieldType.password)
      const PRFLeadingCapitalizationFormatter(),
  ];

  Widget? get _prefixIcon => switch (widget.type) {
    PRFTextFieldType.email => const Icon(Icons.email_outlined),
    PRFTextFieldType.password => const Icon(Icons.lock_outline),
    _ => null,
  };

  Widget get _visibilityToggle => Semantics(
    label: 'Toggle password visibility',
    child: IconButton(
      onPressed: _toggleVisibility,
      icon: Icon(
        _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
    ),
  );
}
