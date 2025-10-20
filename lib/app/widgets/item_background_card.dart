import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemBackgroundCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String restaurant;
  final double price;
  final VoidCallback onAddToCart;

  // 👇 Optional restaurant details
  final String? address;
  final String? contactNo;
  final List<String>? openDays;
  final String? openTime;

  // 👇 Optional extra child content
  final Widget? child;

  const ItemBackgroundCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.restaurant,
    required this.price,
    required this.onAddToCart,
    this.address,
    this.contactNo,
    this.openDays,
    this.openTime,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background split color
        Column(
          children: [
            Container(height: size.height * 0.3, color: colors.primary),
            Container(color: Colors.white, height: size.height * 0.7),
          ],
        ),

        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            onPressed: () => Get.back(), // or
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(230),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.arrow_back, color: Colors.black87),
            ),
          ),
        ),
        // Foreground card
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 70),
                      Text(
                        title,
                        style: textTheme.headlineLarge?.copyWith(
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Restaurant name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.storefront,
                              color: colors.secondary, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            restaurant,
                            style: TextStyle(
                              color: colors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Optional restaurant details
                      if (address != null ||
                          contactNo != null ||
                          openDays != null ||
                          openTime != null)
                        Column(
                          children: [
                            if (address != null)
                              Text(
                                address!,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[700]),
                                textAlign: TextAlign.center,
                              ),
                            if (contactNo != null)
                              Text(
                                "📞 $contactNo",
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[700]),
                              ),
                            if (openTime != null)
                              Text(
                                openTime != null ? '$openTime' : '',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[700]),
                              ),
                            if (openDays != null)
                              Text(
                                "${(openDays ?? '')}",
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[700]),
                              ),
                            const SizedBox(height: 12),
                          ],
                        ),

                      // Optional extra child
                      if (child != null) child!,

                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₱${price.toStringAsFixed(2)}",
                            style: textTheme.headlineLarge?.copyWith(
                              color: colors.primary,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: onAddToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.add_shopping_cart,
                                color: Colors.white),
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Overlapping image
                Positioned(
                  top: 35,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
