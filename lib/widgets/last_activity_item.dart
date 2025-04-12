import 'package:flutter/material.dart';

import '../style/colors/calco_colors.dart';

class LastActivityItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;

  const LastActivityItem({
    required this.imageUrl,
    required this.title,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CalcoColors.secondary.color,
            ),
            child: Image.asset(
              imageUrl,
              width: 21,
              height: 21,
            ),
          ),
          const SizedBox(width: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 5),
              Text(time,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: CalcoColors.grey.color)),
            ],
          )
        ],
      ),
    );
  }
}
