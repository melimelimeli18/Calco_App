import 'package:flutter/material.dart';

import '../style/colors/calco_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.title,
    this.color,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? CalcoColors.primary.color),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
