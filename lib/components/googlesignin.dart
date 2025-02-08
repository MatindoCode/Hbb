import 'package:flutter/material.dart';

class GoogleSignIn extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const GoogleSignIn({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 4, // Set button width
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.g_translate_sharp, color: Colors.white),
            SizedBox(width: 10), // Space between icon and text
            Text(
              "Sign in with Google",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}