import 'package:calco/pages/login_page.dart';
import 'package:calco/pages/meditation_guide_page.dart';
import 'package:calco/pages/meditation_home_page.dart';
import 'package:calco/pages/meditation_review_page.dart';
import 'package:calco/pages/role_user_page.dart';
import 'package:calco/pages/sign_up_page.dart';
import 'package:calco/providers/audio_provider.dart';
import 'package:calco/providers/auth_provider.dart';
import 'package:calco/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/welcome_page.dart';
import 'services/audio_service.dart';
import 'static/navigation_route.dart';
import 'style/theme/calco_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthService(),
        ),
        Provider(
          create: (_) => AudioService(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioProvider(
            context.read<AudioService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calco App',
      theme: CalcoTheme.lightTheme,
      darkTheme: CalcoTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false, // <-- Hilangkan banner DEBUG
      initialRoute: NavigationRoute.welcomeRoute.name,
      routes: {
        NavigationRoute.welcomeRoute.name: (context) => const WelcomePage(),
        NavigationRoute.homeRoute.name: (context) => const HomePage(),
        NavigationRoute.loginRoute.name: (context) => const LoginPage(),
        NavigationRoute.registerRoute.name: (context) => const SignUpPage(),
        NavigationRoute.roleUserRoute.name: (context) => const RoleUserPage(),
        NavigationRoute.meditationHomeRoute.name: (context) =>
            const MeditationHomePage(),
        NavigationRoute.meditationGuideRoute.name: (context) =>
            const MeditationGuidePage(),
        NavigationRoute.meditationReviewRoute.name: (context) =>
            const MeditationReviewPage(),
      },
    );
  }
}
