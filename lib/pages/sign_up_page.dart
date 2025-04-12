import 'package:calco/providers/auth_provider.dart';
import 'package:calco/widgets/custom_button.dart';
import 'package:calco/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../static/navigation_route.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    try {
      // Cek apakah username atau email sudah terpakai
      final firestore = FirebaseFirestore.instance;

      final usernameQuery = await firestore
          .collection('users')
          .where('username', isEqualTo: usernameController.text.trim())
          .get();

      final emailQuery = await firestore
          .collection('users')
          .where('email', isEqualTo: emailController.text.trim())
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        throw Exception('Username sudah digunakan');
      }

      if (emailQuery.docs.isNotEmpty) {
        throw Exception('Email sudah digunakan');
      }

      // Kalau aman, lanjut daftar
      await authProvider.signUp(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Setelah berhasil signup, simpan user ke Firestore
      final user = authProvider.user;
      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'createdAt': Timestamp.now(),
        });
      }

      // Sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil')),
      );

      // Optional: Navigasi ke halaman lain setelah daftar
      Navigator.pushNamedAndRemoveUntil(
        context,
        NavigationRoute.roleUserRoute.name,
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      body: Stack(
        children: [
          // Background abu-abu
          Container(
            color: Colors.grey.shade300,
          ),
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/icon_app.png",
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Register Akun",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfield(
                      title: "Username",
                      hintText: "Ketikkan username disini",
                      controller: usernameController,
                      textInputType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      title: "Email",
                      hintText: "johndoe@gmail.com",
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email tidak boleh kosong";
                        }

                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return "Format email salah";
                        }

                        return null;
                      },
                    ),
                    CustomTextfield(
                      title: "Pasword",
                      hintText: "Masukkan password disini",
                      controller: passwordController,
                      textInputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password tidak boleh kosong";
                        } else if (value != passwordController.text) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      title: "Pasword",
                      hintText: "Konfirmasi ulang password",
                      controller: confirmPasswordController,
                      textInputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Konfirmasi Password tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          title: isLoading ? "Loading..." : "Daftar Akun",
                          onPressed: isLoading ? null : _submit,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
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
