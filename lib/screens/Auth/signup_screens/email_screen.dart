import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/Auth/auth_data.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/confirmation_code_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<EmailScreen> {
  bool _hasError = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userDataProvider);
    // Next Page method of username
    void nextPage() {
      final mail = _emailController.text;
      user.getEmail(mail);
      if (_formKey.currentState!.validate()) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ConfirmationScreen(email: _emailController.text),
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(gradient: gradient),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Floating back button
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                alignment: Alignment.topLeft,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              //Title
              Text(
                "What's you email?",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),

              //Title Body
              const Text(
                'Enter the email where you can be contacted. No one will see this on your profile.',
              ),
              const SizedBox(height: 24),

              //Username Text Field
              TextInputField(
                hasError: _hasError,
                icon: _isTextFocused ? Icons.clear : null,
                labelText: 'Email',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      _hasError = true;
                    });
                    return 'Email required.';
                  }
                  if (!value.contains('@') ||
                      (!value.endsWith('gmail.com') &&
                          !value.endsWith('yahoo.com') &&
                          !value.endsWith('outlook.com') &&
                          !value.endsWith('hotmail.com') &&
                          !value.endsWith('aol.com'))) {
                    setState(() {
                      _hasError = true;
                    });
                    return 'Enter a valid email address.';
                  }
                  setState(() {
                    _hasError = false;
                  });
                  return null;
                },
                onPressed: _isTextFocused
                    ? () {
                        _emailController.clear();
                      }
                    : null,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                isFocusedCallback: updateIsTextFocused,
              ),
              const SizedBox(height: 24),

              //Next Button
              InkWell(
                onTap: () {
                  nextPage();
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
      )),
    );
  }
}
