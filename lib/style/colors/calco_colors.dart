import 'package:flutter/material.dart';

enum CalcoColors {
  primary("kPrimary", Color(0xff99008F)),
  pastelPrimary("kPasterPrimary", Color(0xffFDE0FB)),
  secondary("kSecondary", Color(0xffFDE0FB)),
  primaryGreen("kPrimaryGreen", Color(0xff37A841)),
  secondaryGreen("kSecondaryGreen", Color(0xffB1FFAB)),
  grey("kGrey", Color(0xff9B9299)),
  secondGrey("kSecondGrey", Color(0xffB2B2B2)),
  primaryBlue("kPrimaryBlue", Color(0xff19759C)),
  secondaryBlue("kSecondaryBlue", Color(0xff4EB3DF)),
  blueBackground("kBlueBackground", Color(0xffACDCF0));

  const CalcoColors(this.name, this.color);

  final String name;
  final Color color;
}
