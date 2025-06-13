import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../constants/app_constants.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool showDeleteButton;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onDelete,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppConstants.defaultBorderRadius,
                    ),
                    child: product.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: product.imageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: Icon(Icons.image, color: Colors.grey[400]),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.grey[400],
                              ),
                            ),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                            ),
                          ),
                  ),
                  SizedBox(width: AppConstants.defaultPadding),
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppConstants.smallPadding),
                        Text(
                          'Barcode: ${product.barcode}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: AppConstants.smallPadding),
                        // Match Status
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.smallPadding,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.isCompatible()
                                ? Color(
                                    AppConstants.successColor,
                                  ).withOpacity(0.1)
                                : Color(
                                    AppConstants.errorColor,
                                  ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppConstants.defaultBorderRadius,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                product.isCompatible()
                                    ? Icons.check_circle
                                    : Icons.error_outline,
                                size: 16,
                                color: product.isCompatible()
                                    ? Color(AppConstants.successColor)
                                    : Color(AppConstants.errorColor),
                              ),
                              SizedBox(width: 4),
                              Text(
                                product.isCompatible()
                                    ? 'Compatible'
                                    : 'Not Compatible',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: product.isCompatible()
                                      ? Color(AppConstants.successColor)
                                      : Color(AppConstants.errorColor),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showDeleteButton && onDelete != null)
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete_outline,
                        color: Color(AppConstants.errorColor),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                ],
              ),
              if (!product.isCompatible()) ...[
                SizedBox(height: AppConstants.defaultPadding),
                Text(
                  'Incompatible with:',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: AppConstants.smallPadding),
                Wrap(
                  spacing: AppConstants.smallPadding,
                  runSpacing: AppConstants.smallPadding,
                  children: product.getIncompatibleItems().map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.smallPadding,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(AppConstants.errorColor).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                      ),
                      child: Text(
                        item,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Color(AppConstants.errorColor),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
