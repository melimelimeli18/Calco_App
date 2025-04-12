import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  const EmojiButton({
    required this.imageUrl,
    required this.title,
    this.onTap,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 91,
            height: 91,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: isSelected
                    ? Border.all(color: const Color(0xff2FA7D9), width: 1)
                    : null,
                color: isSelected
                    ? const Color(0xff80D3F7)
                    : const Color(0xffCBE9F4),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff010101).withOpacity(0.05),
                      offset: const Offset(2, 3),
                      blurRadius: 9.9)
                ]),
            child: Image.asset(
              imageUrl,
              width: 40,
              height: 40,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
