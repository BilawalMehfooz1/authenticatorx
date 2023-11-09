import 'package:authenticatorx/screens/Auth/signup_screens/username_screen.dart';
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
  bool _visibility = true;
  bool _isTextFocused = false;
  bool _isFirstDialog = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() {
          _isFirstDialog = true;
        });
      } else {
        setState(() {
          _isFirstDialog = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  //change to sign up screen
  void signUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const UserNameScreen();
        },
      ),
    );
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
                //Language change Button
                Visibility(
                  visible: !_isTextFocused,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'English (US)',
                      style: TextStyle(
                        color: greyColor,
                      ),
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
                  isFocusedCallback: updateIsTextFocused,
                  controller: _emailController,
                  icon: _isFirstDialog ? Icons.clear : null,
                  validator: (p0) {
                    return null;
                  },
                  onPressed: () {
                    setState(() {
                      _emailController.clear();
                    });
                  },
                ),
                const SizedBox(height: 12),

                //Password Input Field
                TextInputField(
                  labelText: 'Enter your password',
                  obsecureText: _visibility,
                  keyboardType: TextInputType.text,
                  isFocusedCallback: updateIsTextFocused,
                  controller: _passwordController,
                  icon: _visibility ? Icons.visibility_off : Icons.visibility,
                  validator: (p0) {
                    return null;
                  },
                  onPressed: () {
                    setState(() {
                      _visibility = !_visibility;
                    });
                  },
                ),
                const SizedBox(height: 12),

                //Login Button
                InkWell(
                  onTap: () {
                    signUp();
                  },
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

                //Forgor Password Button
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                //switch to sign up
                Visibility(
                  visible: !_isTextFocused,
                  child: InkWell(
                    onTap: signUp,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
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
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
