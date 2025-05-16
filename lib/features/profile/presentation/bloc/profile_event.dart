import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final String username;

  LoadProfileEvent({this.username = ''});

  @override
  List<Object> get props => [username];
}

class ToggleFollowEvent extends ProfileEvent {
  final String username;
  final bool isFollowing;

  ToggleFollowEvent({
    required this.username,
    required this.isFollowing,
  });

  @override
  List<Object> get props => [username, isFollowing];
}