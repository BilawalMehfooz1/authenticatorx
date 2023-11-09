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
  bool _isLoading = false;
  bool _isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _confirmationController.dispose();
  }

  // Next Page method of username
  void nextPage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  void updateIsTextFocused(bool isFocused) {
    setState(() {
      _isTextFocused = isFocused;
    });
  }

  // Go Back Screen Method for Button on Top
  void _goBack() {
    Navigator.of(context).pop();
  }

  //Confirmation Code Validator
  String? _validator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Code is required. Check you email to find the code.';
    }
    if (value.trim().length < 6) {
      return ' Code is too short.Check that you entered it correctly and try again.';
    }
    return null;
  }

  // Clear Username Controller
  void _clearController() {
    if (_isTextFocused) {
      _confirmationController.clear();
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
                'Enter the confirmation code',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),

              //Title Body
              Text(
                  "To confirm you account, enter the 6-digit code we sent to ${widget.email}."),
              const SizedBox(height: 24),

              //Username Text Field
              TextInputField(
                icon: _isTextFocused ? Icons.clear : Icons.info_outline,
                labelText: 'Confirmation code',
                validator: _validator,
                onPressed: _clearController,
                keyboardType: TextInputType.number,
                controller: _confirmationController,
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
      )),
    );
  }
}
