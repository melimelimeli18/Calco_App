import 'package:calco/static/navigation_route.dart';
import 'package:calco/style/colors/calco_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/icon_app.png",
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 8),
            Text(
              "Selamat Datang di",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Calco",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CalcoColors.primary.color,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Asisten AI Terapi untuk Membantu Autisme",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: CalcoColors.grey.color,
                  ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              "assets/images/images_home.png",
              width: 260,
              height: 284,
            ),
            const SizedBox(height: 47),
            CustomButton(
              title: "Mulai Sekarang",
              onPressed: () {
                Navigator.pushNamed(context, NavigationRoute.loginRoute.name);
              },
            ),
            const SizedBox(height: 18),
            RichText(
              text: TextSpan(
                  text: "Belum punya akun?",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Daftar',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: CalcoColors.primary.color,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, NavigationRoute.registerRoute.name);
                          })
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
