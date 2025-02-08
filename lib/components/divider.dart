import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String texty;
  const CustomDivider({super.key, required this.texty});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 3, // Adjust thickness as needed
            ),
          ),
          const SizedBox(width: 10), // Add spacing between divider and text
          Text(texty, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10), // Add spacing between text and divider
          const Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 3, // Adjust thickness as needed
            ),
          ),
        ],
      ),
    );
  }
}