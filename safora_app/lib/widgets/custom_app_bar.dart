import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? titleColor;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.titleColor,
    this.bottom,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black87,
        ),
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? Colors.white,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Color(AppConstants.primaryColor),
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : leading,
      actions: actions,
      bottom: bottom,
      iconTheme: IconThemeData(color: Color(AppConstants.primaryColor)),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  static PreferredSizeWidget withSearch({
    required String title,
    required TextEditingController searchController,
    required Function(String) onSearchChanged,
    List<Widget>? actions,
    bool showBackButton = false,
    VoidCallback? onBackPressed,
  }) {
    return CustomAppBar(
      title: title,
      actions: actions,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.defaultPadding),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget withTabs({
    required String title,
    required List<String> tabs,
    required int selectedIndex,
    required Function(int) onTabChanged,
    List<Widget>? actions,
    bool showBackButton = false,
    VoidCallback? onBackPressed,
  }) {
    return CustomAppBar(
      title: title,
      actions: actions,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.smallPadding,
                  vertical: AppConstants.smallPadding / 2,
                ),
                child: ChoiceChip(
                  label: Text(tabs[index]),
                  selected: isSelected,
                  onSelected: (_) => onTabChanged(index),
                  backgroundColor: Colors.grey[100],
                  selectedColor: Color(
                    AppConstants.primaryColor,
                  ).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Color(AppConstants.primaryColor)
                        : Colors.grey[600],
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
