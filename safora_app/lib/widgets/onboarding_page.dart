import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? image;
  final Widget? content;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool showSkipButton;
  final VoidCallback? onSkipPressed;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    this.image,
    this.content,
    this.buttonText,
    this.onButtonPressed,
    this.showSkipButton = false,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            if (showSkipButton)
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: onSkipPressed,
                  child: Text('Skip'),
                ),
              ),
            if (image != null) ...[
              SizedBox(
                height: size.height * 0.3,
                child: Center(child: image),
              ),
              SizedBox(height: AppConstants.largePadding),
            ],
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstants.smallPadding),
            Text(
              subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstants.largePadding),
            if (content != null) ...[
              Expanded(child: content!),
              SizedBox(height: AppConstants.largePadding),
            ],
            if (buttonText != null && onButtonPressed != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  child: Text(buttonText!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage
                ? Color(AppConstants.primaryColor)
                : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
