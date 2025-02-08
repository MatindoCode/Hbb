import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/components/alreadylogin.dart';
import 'package:flutter_application_1/components/bottom_navigate.dart';
import 'package:flutter_application_1/components/divider.dart';
import 'package:flutter_application_1/components/googlesignin.dart';
import 'package:flutter_application_1/components/loginContainer.dart';
import 'package:flutter_application_1/components/loginbutton.dart';
import 'package:flutter_application_1/ui/signup/signup.dart';

class Login extends StatelessWidget {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 85, 214),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Stack(children: [
              Positioned.fill(
                child: Image.asset("images/login.png", fit: BoxFit.fill),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    const Text("Log in to BBH",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    const GoogleSignIn(text: "Sign in with Google"),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomDivider(texty: "Or Log in With Email"),
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SignInLogin(
                          hintText: "Login",
                          controller: loginController,
                          isPassword: false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SignInLogin(
                          hintText: "Password",
                          controller: passwordController,
                          isPassword: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   Loginbutton(
  onPressed: () async {
  try {
    // Instantiate AuthService
    final authService = AuthService();

    // Attempt to sign in with the provided email and password
    final response = await authService.signInWithEmailPassword(
      email: loginController.text.trim(), // Trim input to remove extra spaces
      password: passwordController.text,
    );
     if (response.session?.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NaviBar()),
        );}
  } catch (e) {
    print('Login failed: $e');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text("Login Failed"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
},),
                    const SizedBox(
                      height: 20,
                    ),
                    AlreadyNoAccount(
                      text1: "Already have an account?",
                      text2: "Login",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                    ),
                  ]),
            ]),
          ),
        ),
      ),
    );
  }
}
