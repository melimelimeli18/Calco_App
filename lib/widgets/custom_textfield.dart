import 'package:calco/style/colors/calco_colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String title;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? errorText;

  const CustomTextfield({
    required this.title,
    this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.errorText,
    super.key,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: CalcoColors.grey.color,
                ),
            errorText: widget.errorText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: CalcoColors.secondGrey.color, width: 1)),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: CalcoColors.grey.color,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
