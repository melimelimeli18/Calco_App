import 'package:flutter/material.dart';

import '../style/colors/calco_colors.dart';

class CustomTimeButton extends StatelessWidget {
  final String? time;
  final String? imageUrl;
  final String? title;
  final VoidCallback? onTap;
  final bool isSelected;

  const CustomTimeButton({
    this.time,
    this.imageUrl,
    this.title,
    this.onTap,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 104,
            height: 84,
            margin: const EdgeInsets.only(bottom: 12, right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: isSelected ? CalcoColors.primary.color : Colors.white),
              borderRadius: BorderRadius.circular(8),
              color:
                  isSelected ? CalcoColors.pastelPrimary.color : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff010101).withOpacity(0.05),
                  offset: const Offset(2, 3),
                  blurRadius: 9.9,
                )
              ],
            ),
            alignment: Alignment.center,
            child: time != null
                ? Text(
                    time!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  )
                : Image.asset(
                    imageUrl!,
                    width: 30,
                    height: 30,
                  ),
          ),
          Text(
            title ?? "Menit",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
