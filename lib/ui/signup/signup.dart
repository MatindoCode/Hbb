import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/alreadySignup.dart';
import 'package:flutter_application_1/components/divider.dart';
import 'package:flutter_application_1/components/googlesignin.dart';
import 'package:flutter_application_1/components/signupContainer.dart';
import 'package:flutter_application_1/components/signupbutton.dart';
import 'package:flutter_application_1/ui/login/login.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmpwController = TextEditingController();

  Signup({super.key});

  /// Method to handle signup logic
  void _signUp(BuildContext context) async {
  final email = emailController.text.trim();
  final password = pwController.text.trim();
  final confirmPassword = confirmpwController.text.trim();
  final username = nameController.text.trim();

  if (username.isEmpty) {
    // Show an error message when username is empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Username is required"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  if (password != confirmPassword) {
    // Show an error message when passwords don't match
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Passwords don't match"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    // Call AuthService to handle signup
    final authService = AuthService();
    final response = await authService.signUpWithEmailPassword(
      email: email,
      password: password,
    );

    // Get the user ID from the signup response
    final userId = response.user?.id;

    // Save the user's name (username) in the profiles table
    if (userId != null) {
      final supabase = Supabase.instance.client;

      await supabase.from('profiles').upsert({
        'id': userId,
        'name': username, // Add the username to the profile data
        'created_at': DateTime.now().toIso8601String(),
      });

    }

    // Navigate to the login screen or home screen after signup
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signup successful!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }  catch (e, stacktrace) {
  print('Error during signup: $e');
  print('Stacktrace: $stacktrace');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Signup failed: $e"),
      backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 85, 214),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset("images/signup.png", fit: BoxFit.fill),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    const Text(
                      "Sign up for BBH",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const GoogleSignIn(text: "Sign up with Google"),
                    const SizedBox(height: 20),
                    const CustomDivider(texty: "Or Continue with Email"),
                    const SizedBox(height: 60),
                    SignIn(
                      hintText: "Enter Name",
                      controller: nameController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 20),
                    SignIn(
                      hintText: "Enter Email",
                      controller: emailController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 20),
                    SignIn(
                      hintText: "Enter Password",
                      controller: pwController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    SignIn(
                      hintText: "Confirm Password",
                      controller: confirmpwController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SignupButton(
                            onPressed: () => _signUp(context),
                          ),
                          const SizedBox(height: 20),
                          AlreadyHaveAccount(
                            text1: "Already have an account?",
                            text2: "Login",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}