import 'package:flutter/material.dart';

import '../style/colors/calco_colors.dart';

class ImageIconButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const ImageIconButton({
    required this.imageUrl,
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff010101).withOpacity(0.05),
                offset: const Offset(2, 3),
                blurRadius: 9.9)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              width: 32,
              height: 32,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: CalcoColors.primary.color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
