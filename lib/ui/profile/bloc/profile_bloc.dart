import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_event.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfilePictureEvent>(_updateProfilePictureEvent);
  }

   Future<void> _updateProfilePictureEvent(
    UpdateProfilePictureEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final File imageFile = event.imageFile; // File to upload
      emit(ProfileUpdating()); // Emit loading state
     
      // Get Supabase client instance
      final supabase = Supabase.instance.client;
      
      // Get the current user's ID
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User is not authenticated');
      }
      
    // Fetch the previous profile information
     final previousProfile = await supabase
      .from('profiles')
      .select('profile_picture')
      .eq('id', userId)
      .single();
     final previousFilePath = previousProfile['profile_picture'] as String?;
  
   // Generate a unique file path in the storage bucket
      final uniqueTimestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = 'images/$userId/profile-pic.png-$uniqueTimestamp.png';

  // Update the user's profile in the database
      await supabase.from('profiles').upsert({
        'id': userId,
        'profile_picture': filePath,
      });

      //upload file in bucket
      try {
         print('Uploading new file...');
      await supabase.storage.from('images').upload(filePath, imageFile);
      print('File uploaded successfully.');
    } catch (e) {
      throw Exception('File upload failed: $e');}
       
     
      final publicUrl = supabase.storage.from('images').getPublicUrl(filePath);
       
       //Update new image for user to see  
       emit(ProfileUpdated(imageUrl: publicUrl ));

 
    
    //  remove the old file
   if (previousFilePath != null && previousFilePath.isNotEmpty) {
        try {
          print('Attempting to remove previous file at path: $previousFilePath');
          final removeResponse = await supabase.storage.from('images').remove([previousFilePath]);
          print('Previous file removed successfully: $removeResponse');
        } catch (e) {
          print('Error while removing the previous file: $e');
        }
      }

  

} catch (e) {
      // Emit error state on failure
      emit(ProfileError('Failed to update profile picture: $e'));} }}