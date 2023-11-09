import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:authenticatorx/widgets/Auth/auth_data.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/email_screen.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<PasswordScreen> {
  bool _isLoading = false;
  bool _isVisibile = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  // Go Back Screen Method for Button on Top
  void _goBack() {
    Navigator.of(context).pop();
  }

  // Password Validator
  String? _validator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.trim().length < 6) {
      return 'This assword is too short. Create a longer password with at least 6 letters and numbers.';
    }
    return null;
  }

  // Function to Change Obsecure Text
  void _visibilitySet() {
    setState(() {
      _isVisibile = !_isVisibile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    const width = double.infinity;
    final get = ref.read(userDataProvider);
    final brightness = style.brightness == Brightness.light;
    final gradient = brightness ? gradient1 : gradient2;

    // Next Page method of username
    void nextPage() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        FocusScope.of(context).unfocus();
        get.getPassword(_passwordController.text);

        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmailScreen(),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          decoration: BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.symmetric(horizontal: 20),

          //Form for Text Field Input
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
                  onPressed: _goBack,
                ),

                //Title
                Text(
                  'Create a Password',
                  style: style.textTheme.titleLarge!.copyWith(
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
                  labelText: 'Password',
                  validator: _validator,
                  isFocusedCallback: null,
                  obsecureText: _isVisibile,
                  onPressed: _visibilitySet,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  icon: _isVisibile ? Icons.visibility_off : Icons.visibility,
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
