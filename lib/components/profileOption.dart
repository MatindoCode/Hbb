import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final IconData iconData; // Use IconData for built-in Flutter icons
  const ProfileOption({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Use double precision for clarity
          border: Border.all(color: Colors.black, width: 3.0), // Use double precision for clarity
        ),
        child: Center( // Center the icon within the container
          child: Icon(
            iconData,
            size: 50.0, // Use double precision for clarity
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}