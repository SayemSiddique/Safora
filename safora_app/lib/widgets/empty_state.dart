import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: Color(AppConstants.primaryColor).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: Color(AppConstants.primaryColor),
                ),
              ),
              SizedBox(height: AppConstants.largePadding),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppConstants.smallPadding),
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              if (buttonText != null && onButtonPressed != null) ...[
                SizedBox(height: AppConstants.largePadding),
                SizedBox(
                  width: size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(buttonText!),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Widget noScans({VoidCallback? onScanPressed}) {
    return EmptyState(
      title: 'No Scans Yet',
      message: 'Start scanning food products to see your history here.',
      icon: Icons.qr_code_scanner_outlined,
      buttonText: 'Scan a Product',
      onButtonPressed: onScanPressed,
    );
  }

  static Widget noResults({VoidCallback? onRetryPressed}) {
    return EmptyState(
      title: 'No Results Found',
      message: 'We couldn\'t find any products matching your search.',
      icon: Icons.search_off_outlined,
      buttonText: 'Try Again',
      onButtonPressed: onRetryPressed,
    );
  }

  static Widget error({String? message, VoidCallback? onRetryPressed}) {
    return EmptyState(
      title: 'Something Went Wrong',
      message: message ?? 'An error occurred. Please try again.',
      icon: Icons.error_outline,
      buttonText: 'Retry',
      onButtonPressed: onRetryPressed,
    );
  }
}
