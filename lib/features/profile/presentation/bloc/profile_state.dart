import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/api_call_status.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends BaseApiState {
  @override
  MyApiStatus toApiStatus() => Holding();
}

final class ProfileLoading extends BaseApiState {
  @override
  MyApiStatus toApiStatus() => Loading();
}

class ProfileLoaded extends BaseApiState {
  final ProfileEntity profile;

  ProfileLoaded({required this.profile});

  @override
  MyApiStatus toApiStatus() => Success();

  @override
  List<Object> get props => [profile];
}

class ProfileError extends BaseApiState {
  final String message;

  ProfileError({required this.message});

  @override
  MyApiStatus toApiStatus() => Error(message: message);

  @override
  List<Object> get props => [message];
}
