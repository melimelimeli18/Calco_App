import 'package:calco/static/navigation_route.dart';
import 'package:flutter/material.dart';

import '../style/colors/calco_colors.dart';

class RoleUserPage extends StatelessWidget {
  const RoleUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background dan ClipPath
            Stack(
              children: [
                Container(
                  height: 250,
                  color: Colors.grey.shade300,
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
                              text: "Siapa",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    letterSpacing: 1.5,
                                    color: CalcoColors.primary.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' yang akan\nmenggunakan aplikasi ini?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
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
                    RoleImageButton(
                      title: "Dokter Terapis",
                      imageUrl: "assets/images/images_doctor.png",
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            NavigationRoute.homeRoute.name, (route) => false);
                      },
                    ),
                    RoleImageButton(
                      title: "Orang Tua",
                      imageUrl: "assets/images/images_parent.png",
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            NavigationRoute.homeRoute.name, (route) => false);
                      },
                    ),
                    RoleImageButton(
                      title: "Seseorang dengan autisme",
                      imageUrl: "assets/images/image_autism.png",
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            NavigationRoute.meditationHomeRoute.name,
                            (route) => false);
                      },
                    ),
                  ],
                )),

            const SizedBox(height: 32), // Tambahin biar ga mentok bawah
          ],
        ),
      ),
    );
  }
}

class RoleImageButton extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const RoleImageButton({
    required this.title,
    required this.imageUrl,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(bottom: 26),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff010101).withOpacity(0.05),
                  offset: const Offset(2, 3),
                  blurRadius: 9.9)
            ]),
        child: Column(
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
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
