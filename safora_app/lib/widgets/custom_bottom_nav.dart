import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

enum NavItem { scan, history, profile }

class CustomBottomNav extends StatelessWidget {
  final NavItem currentItem;
  final Function(NavItem) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.smallPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                NavItem.scan,
                Icons.qr_code_scanner,
                'Scan',
              ),
              _buildNavItem(context, NavItem.history, Icons.history, 'History'),
              _buildNavItem(
                context,
                NavItem.profile,
                Icons.person_outline,
                'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item,
    IconData icon,
    String label,
  ) {
    final isSelected = currentItem == item;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(item),
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(AppConstants.primaryColor).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Color(AppConstants.primaryColor)
                  : Colors.grey[600],
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Color(AppConstants.primaryColor)
                    : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
