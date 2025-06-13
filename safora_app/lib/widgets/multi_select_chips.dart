import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MultiSelectChips extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final Function(String) onOptionSelected;
  final Function(String) onOptionDeselected;
  final String? title;
  final String? subtitle;

  const MultiSelectChips({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onOptionSelected,
    required this.onOptionDeselected,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
          SizedBox(height: AppConstants.defaultPadding),
        ],
        Wrap(
          spacing: AppConstants.smallPadding,
          runSpacing: AppConstants.smallPadding,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onOptionSelected(option);
                } else {
                  onOptionDeselected(option);
                }
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Color(AppConstants.primaryColor).withOpacity(0.2),
              checkmarkColor: Color(AppConstants.primaryColor),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? Color(AppConstants.primaryColor)
                    : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.smallPadding,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.defaultBorderRadius,
                ),
                side: BorderSide(
                  color: isSelected
                      ? Color(AppConstants.primaryColor)
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
