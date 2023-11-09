import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/screens/home_screen.dart';
import 'package:authenticatorx/widgets/text_input_field.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key, required this.email});
  final String email;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool _hasError = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _confirmationController.dispose();
  }

  // Next Page method of username
  void nextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'Enter the confirmation code',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),

              //Title Body
              Text(
                "To confirm you account, enter the 6-digit code we sent to ${widget.email}.",
              ),
              const SizedBox(height: 24),

              //Username Text Field
              TextInputField(
                hasError: _hasError,
                icon: _isTextFocused ? Icons.clear : Icons.info_outline,
                labelText: 'Confirmation code',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    setState(() {
                      _hasError = true;
                    });
                    return 'Code is required. Check you email to find the code.';
                  }
                  if (value.trim().length < 6) {
                    setState(() {
                      _hasError = true;
                    });
                    return ' Code is too short.Check that you entered it correctly and try again.';
                  }
                  setState(() {
                    _hasError = false;
                  });
                  return null;
                },
                onPressed: _isTextFocused
                    ? () {
                        _confirmationController.clear();
                      }
                    : null,
                controller: _confirmationController,
                keyboardType: TextInputType.number,
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
