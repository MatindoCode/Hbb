import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/profileOption.dart';

import 'package:flutter_application_1/components/profilepic.dart';
import 'package:flutter_application_1/components/updatedetails.dart';
import 'package:flutter_application_1/components/updatepic.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_bloc.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_event.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Convert the selected image to a File and pass its path to the event
      final File imageFile = File(image.path);
      context.read<ProfileBloc>().add(UpdateProfilePictureEvent(imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // BlocBuilder to handle profile picture updates
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                String imageUrl = ''; // Default value for imageUrl

                if (state is ProfileUpdated) {
                  imageUrl = state.imageUrl; // Assign the updated image URL
                }

                return Profilepic(
                    imageUrl: imageUrl.isNotEmpty
                        ? imageUrl
                        : null); // Use the imageUrl for the widget
              },
            ),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Updatepic(
                  onPressed: () => _pickImage(context),
                ),
                UpdateDetails(onPressed: () {})
              ],
            ),
            const SizedBox(height: 30),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                ProfileOption(iconData: Icons.favorite),
                ProfileOption(iconData: Icons.shopping_bag),
                ProfileOption(iconData: Icons.diversity_1),
                ProfileOption(iconData: Icons.favorite)
              ],),
            ),
            ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black, // Set button color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Rounded corners
    ),
    padding: const EdgeInsets.symmetric(vertical: 15), // Add vertical padding
  ),
  onPressed: () => Navigator.pop(context), // Wrap logic in an arrow function
  child: const Text("Go Back", style: TextStyle(color: Colors.white)),
)
          ],
        ),
      ),
    );
  }
}
