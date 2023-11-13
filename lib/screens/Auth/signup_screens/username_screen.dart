import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/widgets/Auth/text_input_field.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/password_screen.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  bool _isLoading = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  //Method to Display Different Icons on Either Field Focused or Not Condition
  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  // Go Back Screen Method for Button on Top
  void _goBack() {
    Navigator.of(context).pop();
  }

  // Username Validator
  String? _validator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Choose a username to continue.';
    }
    if (value.trim().length < 4) {
      return 'Username must be atleast 4 characters.';
    }

    return null;
  }

  // Clear Username Controller
  void _clearController() {
    if (_isTextFocused) {
      _usernameController.clear();
    }
  }

  // Next Page method of username
  void nextPage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                PasswordScreen(username: _usernameController.text),
          ),
        );
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
          width: width,
          decoration: BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.symmetric(horizontal: 20),

          //Form for Text Input Field
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button on Top
                IconButton(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                  alignment: Alignment.topLeft,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _goBack,
                ),

                //Title
                Text(
                  'Create a username',
                  style: style.textTheme.titleLarge!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                //Title Body
                const Text(
                    'Add a username. You can change this username at any time.'),
                const SizedBox(height: 24),

                //Username Text Field
                TextInputField(
                  icon: _isTextFocused ? Icons.clear : Icons.info_outline,
                  labelText: 'Username',
                  validator: _validator,
                  onPressed: _clearController,
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
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
