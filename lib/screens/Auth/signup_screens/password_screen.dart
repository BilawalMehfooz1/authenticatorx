import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/Auth/auth_data.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/email_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<PasswordScreen> {
  bool _hasError = false;
  bool _isVisibile = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.read(userDataProvider);

    // Next Page method of username
    void nextPage() {
      final password = _passwordController.text;
      data.getPassword(password);
      if (_formKey.currentState!.validate()) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EmailScreen(),
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
                'Create a Password',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),

              //Title Body
              const Text(
                "Create a password with at least 6 letters or numbers. It should be something others can't guess.",
              ),
              const SizedBox(height: 24),

              //Username Text Field
              TextInputField(
                hasError: _hasError,
                icon: _isVisibile ? Icons.visibility_off : Icons.visibility,
                labelText: 'Password',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      _hasError = true;
                    });
                    return 'Password cannot be empty.';
                  }
                  if (value.trim().length < 6) {
                    _hasError = true;
                    return ' This password is too short. Create a longer password with at least 6 letters and numbers.';
                  }
                  setState(() {
                    _hasError = false;
                  });
                  return null;
                },
                onPressed: () {
                  setState(() {
                    _isVisibile = !_isVisibile;
                  });
                },
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obsecureText: _isVisibile,
                isFocusedCallback: null,
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
