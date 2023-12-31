import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/data/error_messages.dart';
import 'package:authenticatorx/widgets/Auth/auth_methods.dart';
import 'package:authenticatorx/widgets/Auth/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/username_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
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

  // clear controller Function
  void clearController() {
    _emailController.clear();
  }

  // Remove visibility
  void visibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  // Email Validator
  String? _emailValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email required.';
    }
    if (!value.contains('@') ||
        (!value.endsWith('gmail.com') &&
            !value.endsWith('yahoo.com') &&
            !value.endsWith('outlook.com') &&
            !value.endsWith('hotmail.com') &&
            !value.endsWith('aol.com'))) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  // Password Validator
  String? _passwordValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.trim().length < 6) {
      return 'This assword is too short. Create a longer password with at least 6 letters and numbers.';
    }
    return null;
  }

  // Login Method
  void _logIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final res = await AuthMethods().logInMethod(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (res == 'success') {
      } else {
        if (context.mounted) {
          showErrorDialog(context: context, content: res);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const width = double.infinity;
    final style = Theme.of(context);
    final brightness = style.brightness == Brightness.light;
    final gradient = brightness ? gradient1 : gradient2;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  onPressed: clearController,
                  validator: _emailValidator,
                  labelText: 'Enter your email',
                  controller: _emailController,
                  isFocusedCallback: updateIsTextFocused,
                  keyboardType: TextInputType.emailAddress,
                  icon: _isFirstDialog ? Icons.clear : null,
                ),
                const SizedBox(height: 12),

                //Password Input Field
                TextInputField(
                  obsecureText: _visibility,
                  labelText: 'Enter your password',
                  validator: _passwordValidator,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  isFocusedCallback: updateIsTextFocused,
                  onPressed: visibility,
                  icon: _visibility ? Icons.visibility_off : Icons.visibility,
                ),
                const SizedBox(height: 12),

                //Login Button
                InkWell(
                  onTap: _logIn,
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: blueColor,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: whiteColor)
                        : const Text(
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
                  onPressed: _isLoading ? null : () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: brightness ? blackColor : whiteColor,
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                //switch to sign up
                Visibility(
                  visible: !_isTextFocused,
                  child: InkWell(
                    onTap: _isLoading ? null : signUp,
                    child: Container(
                      width: width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: blueColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Text(
                        'Create new account',
                        style: TextStyle(
                          fontSize: 16,
                          color: blueColor,
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
