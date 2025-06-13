import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

enum ButtonVariant { primary, secondary, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.primary
                    ? Colors.white
                    : Color(AppConstants.primaryColor),
              ),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 20, color: _getIconColor(theme)),
            SizedBox(width: AppConstants.smallPadding),
          ],
          Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: _getTextColor(theme),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );

    if (isFullWidth) {
      buttonChild = SizedBox(width: double.infinity, child: buttonChild);
    }

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Color(AppConstants.primaryColor),
            foregroundColor: textColor ?? Colors.white,
          ),
          child: buttonChild,
        );

      case ButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? Color(AppConstants.primaryColor),
            side: BorderSide(
              color: backgroundColor ?? Color(AppConstants.primaryColor),
              width: 2,
            ),
          ),
          child: buttonChild,
        );

      case ButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? Color(AppConstants.primaryColor),
          ),
          child: buttonChild,
        );
    }
  }

  Color _getTextColor(ThemeData theme) {
    if (textColor != null) return textColor!;

    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
      case ButtonVariant.text:
        return Color(AppConstants.primaryColor);
    }
  }

  Color _getIconColor(ThemeData theme) {
    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
      case ButtonVariant.text:
        return Color(AppConstants.primaryColor);
    }
  }
}
