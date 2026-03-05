import 'package:flutter/material.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ItemSchimmerAyah extends StatelessWidget {
  const ItemSchimmerAyah({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: size.height / 14,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: size.height / 28,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: size.height / 28,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
