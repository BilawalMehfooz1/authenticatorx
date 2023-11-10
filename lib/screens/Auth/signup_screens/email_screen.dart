import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';
import 'package:authenticatorx/widgets/Auth/auth_methods.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({
    super.key,
    required this.username,
    required this.password,
  });

  final String username, password;

  @override
  State<EmailScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<EmailScreen> {
  bool _isLoading = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  //Method to Display Different Icon info or Icon clear based on Condition
  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  // Go Back Screen Method for Button on Top
  void _goBack() {
    Navigator.of(context).pop();
  }

  // Email Validator
  String? _validator(value) {
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

  // Clear Username Controller
  void _clearController() {
    if (_isTextFocused) {
      _emailController.clear();
    }
  }

  // Continue Method 
  void nextPage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final result = await AuthMethods().sendEmailVerification(
        context: context,
        email: _emailController.text,
        password: widget.password,
        username: widget.username,
      );

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        if (result == 'success') {
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      }
    }
  }

  // Resend Method

  @override
  Widget build(BuildContext context) {
    const width = double.infinity;
    final style = Theme.of(context);
    final brightness = style.brightness == Brightness.light;
    final gradient = brightness ? gradient1 : gradient2;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          decoration: BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.symmetric(horizontal: 20),

          // Form for Text Input Field
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Floating back button
                IconButton(
                  onPressed: _goBack,
                  alignment: Alignment.topLeft,
                  icon: const Icon(Icons.arrow_back),
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                ),

                //Title
                Text(
                  "What's you email?",
                  style: style.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),

                //Title Body
                const Text(
                    'Enter the email where you can be contacted. No one will see this on your profile.'),
                const SizedBox(height: 24),

                //Username Text Field
                TextInputField(
                  icon: _isTextFocused ? Icons.clear : null,
                  labelText: 'Email',
                  validator: _validator,
                  onPressed: _clearController,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isFocusedCallback: updateIsTextFocused,
                ),
                const SizedBox(height: 24),

                //Next Button
                InkWell(
                  onTap: _isLoading ? null : nextPage,
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
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              color: whiteColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
