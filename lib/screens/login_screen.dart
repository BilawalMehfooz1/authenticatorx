import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: gradient,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'English (US)',
                    style: TextStyle(
                      color: greyColor,
                    ),
                  ),
                ),
                const Spacer(),

                //Login Logo Picture
                SvgPicture.asset(
                  'assets/images/security.svg',
                  height: 100,
                ),
                const Spacer(),

                //Email Input Field
                TextInputField(
                  labelText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  icon: Icons.clear,
                ),
                const SizedBox(height: 12),

                //Password Input Field
                TextInputField(
                  labelText: 'Enter your password',
                  obsecureText: true,
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  icon: Icons.visibility_off,
                ),
                const SizedBox(height: 12),

                //Login Button
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: blueColor,
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                //switch to sign up
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: blueColor),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Colors.transparent,
                    ),
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
