
import 'package:flutter/material.dart';

class UpdateDetails extends StatelessWidget {
  final Function onPressed; // Callback function for handling clicks

  const  UpdateDetails({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        onPressed: () => onPressed(), // Call the callback function on press
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29.0),
          ), backgroundColor: Colors.white, // Match container color
          padding: EdgeInsets.zero, // Remove default padding
           minimumSize: const Size(150, 30)
        ),
        child: const Text(
          "Update Profile",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

