import 'package:flutter/material.dart';


class Profilepic extends StatelessWidget {
  final String? imageUrl; // Full URL or null

  const Profilepic({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey, // Placeholder background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!, // Use the full public URL
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(), // Show loading spinner
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red), // Error icon
                  );
                },
              )
            : Image.asset(
                "images/profilepic.png", // Local placeholder image path
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}