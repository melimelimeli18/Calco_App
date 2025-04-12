import 'package:calco/static/navigation_route.dart';
import 'package:calco/style/colors/calco_colors.dart';
import 'package:calco/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../widgets/emoji_button.dart';

class MeditationHomePage extends StatefulWidget {
  const MeditationHomePage({super.key});

  @override
  State<MeditationHomePage> createState() => _MeditationHomePageState();
}

class _MeditationHomePageState extends State<MeditationHomePage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CalcoColors.blueBackground.color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                ),
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Halo, John! ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '🐬',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    "Bagaimana perasaan kamu\nsekarang?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: CalcoColors.primaryBlue.color),
                  ),
                  const SizedBox(height: 35),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Wrap(
                        spacing: 29,
                        runSpacing: 29,
                        children: List.generate(9, (index) {
                          final titleOptions = [
                            "Tenang",
                            "Bahagia",
                            "Cemas",
                            "Marah",
                            "Frustasi",
                            "Sedih",
                            "Bingung",
                            "Lelah",
                            "Antusias"
                          ];

                          final imageOptions = [
                            "assets/icons/icon_flower.png",
                            "assets/icons/icon_bahagia.png",
                            "assets/icons/icon_cemas.png",
                            "assets/icons/icon_marah.png",
                            "assets/icons/icon_frustasi.png",
                            "assets/icons/icon_sedih.png",
                            "assets/icons/icon_bingung.png",
                            "assets/icons/icon_kewalahan.png",
                            "assets/icons/icon_antusias.png",
                          ];

                          return EmojiButton(
                            imageUrl: imageOptions[index],
                            title: titleOptions[index],
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 70),
                  CustomButton(
                    title: "Hubungkan dengan Guardian",
                    color: CalcoColors.primaryBlue.color,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, NavigationRoute.meditationGuideRoute.name);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // turun sedikit
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0); // ke atas kanan
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
