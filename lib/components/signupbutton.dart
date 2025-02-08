import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final void Function()? onPressed;
  const SignupButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2 / 4, // Set button width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Set button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 15), // Add vertical padding
        ),
        onPressed: onPressed
          // Add your Google Sign-In logic here
        ,
        child: const Text("SignUp", style: TextStyle(color: Colors.white),)
      ),
    );
  }
}