import 'package:flutter/material.dart';

import '../static/navigation_route.dart';
import '../style/colors/calco_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/emoji_button.dart';

class MeditationReviewPage extends StatefulWidget {
  const MeditationReviewPage({super.key});

  @override
  State<MeditationReviewPage> createState() => _MeditationReviewPageState();
}

class _MeditationReviewPageState extends State<MeditationReviewPage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

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
                    "Bagaimana perasaan kamu sekarang setelah melakukan meditasi John? Yuk ceritakan ke aku!",
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
                  const SizedBox(height: 32),
                  TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Ceritakan perasaan kamu disini ...",
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: CalcoColors.grey.color,
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: CalcoColors.secondGrey.color, width: 1),
                          ))),
                  const SizedBox(height: 25),
                  CustomButton(
                    title: "Kirim",
                    color: CalcoColors.primaryBlue.color,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigationRoute.homeRoute.name,
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 52),
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
