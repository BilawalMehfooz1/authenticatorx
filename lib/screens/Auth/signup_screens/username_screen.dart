import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/Auth/auth_data.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/password_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNameScreen extends ConsumerStatefulWidget {
  const UserNameScreen({super.key});

  @override
  ConsumerState<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends ConsumerState<UserNameScreen> {
  bool _hasError = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.read(userDataProvider);
    // Next Page method of username
    void nextPage() {
      if (_formKey.currentState!.validate()) {
        final username = _usernameController.text;
        data.getUsername(username);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PasswordScreen(),
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
                'Create a username',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),

              //Title Body
              const Text(
                  'Add a username. You can change this username at any time.'),
              const SizedBox(height: 24),

              //Username Text Field
              TextInputField(
                hasError: _hasError,
                icon: _isTextFocused ? Icons.clear : Icons.info_outline,
                labelText: 'Username',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      _hasError = true;
                    });
                    return 'Choose a username to continue.';
                  }
                  if (value.trim().length < 4) {
                    setState(() {
                      _hasError = true;
                    });
                    return ' Username must be atleast 4 characters.';
                  }
                  setState(() {
                    _hasError = false;
                  });
                  return null;
                },
                onPressed: _isTextFocused
                    ? () {
                        _usernameController.clear();
                      }
                    : null,
                controller: _usernameController,
                keyboardType: TextInputType.text,
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