import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfilePictureEvent extends ProfileEvent {
  final File imageFile;

  const UpdateProfilePictureEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}