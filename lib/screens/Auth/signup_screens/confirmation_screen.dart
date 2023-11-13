import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:authenticatorx/data/colors.dart';
import 'package:authenticatorx/data/error_messages.dart';
import 'package:authenticatorx/screens/home_screen.dart';
import 'package:authenticatorx/widgets/Auth/auth_methods.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
    required this.email,
    required this.username,
    required this.password,
  });

  final String email;
  final String username;
  final String password;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  // navigate to home screen
  Future<void> _nextPage(BuildContext context) async {
    setState(() {
      _isLoading1 = true;
    });

    final res = await AuthMethods().completeRegistration(
      username: widget.username,
      password: widget.password,
      context: context,
    );

    setState(() {
      _isLoading1 = false;
    });

    // Navigate to the HomeScreen in this case
    if (context.mounted) {
      if (res == 'success') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      } else {
        showErrorDialog(context: context, content: res);
      }
    }
  }

  // Resend email verification method
  Future<void> _resendEmailVerification(BuildContext context) async {
    setState(() {
      _isLoading2 = true;
    });

    final res = await AuthMethods().resendVerificationEmail(
      email: widget.email,
      password: widget.password,
      username: widget.username,
      context: context,
    );

    setState(() {
      _isLoading2 = false;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
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

          // Column for content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Floating back button
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                alignment: Alignment.topLeft,
                icon: const Icon(Icons.arrow_back),
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
              ),

              // Title
              Text('Check your email for verification',
                  style: style.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(height: 12),
              // Mail Icon
              Center(
                child: SvgPicture.asset(
                  'assets/images/email.svg',
                  height: 150,
                ),
              ),
              const SizedBox(height: 24),
              // Title Body
              Text(
                  'To confirm your account, verify your account via the link that we sent to ${widget.email}.'),
              const SizedBox(height: 24),

              // Continue Button
              InkWell(
                onTap: _isLoading2
                    ? null
                    : _isLoading1
                        ? null
                        : () {
                            _nextPage(context);
                          },
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: _isLoading1
                      ? const CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: whiteColor,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              // Resend Button
              InkWell(
                onTap: _isLoading2
                    ? null
                    : _isLoading1
                        ? null
                        : () {
                            _resendEmailVerification(context);
                          },
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: blueColor),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: _isLoading2
                      ? const CircularProgressIndicator(
                          color: blueColor,
                        )
                      : const Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 16,
                            color: blueColor,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
