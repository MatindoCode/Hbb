// import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String imageUrl;

  const ProfileUpdated({required this.imageUrl});

  @override
  List<Object?> get props => [imageUrl];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}