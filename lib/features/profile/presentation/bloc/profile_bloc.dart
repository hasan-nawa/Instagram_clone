import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/profile/domain/usecases/follow_user.dart';
import 'package:instagram_clone/features/profile/domain/usecases/get_user_profile.dart';
import 'package:instagram_clone/features/profile/domain/usecases/unfollow_user.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_event.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, BaseApiState> {
  final GetUserProfile getUserProfile;
  final FollowUser followUser;
  final UnfollowUser unfollowUser;

  ProfileBloc({
    required this.getUserProfile,
    required this.followUser,
    required this.unfollowUser,
  }) : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<ToggleFollowEvent>(_onToggleFollow);
  }

  void _onLoadProfile(LoadProfileEvent event, Emitter<BaseApiState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await getUserProfile(event.username);
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  void _onToggleFollow(ToggleFollowEvent event, Emitter<BaseApiState> emit) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final currentProfile = currentState.profile;

      // Create updated profile with new followers count
      final updatedProfile = currentProfile.copyWith(
        followersCount: event.isFollowing
            ? currentProfile.followersCount - 1
            : currentProfile.followersCount + 1,
      );

      // Emit the new state immediately for responsive UI
      emit(ProfileLoaded(profile: updatedProfile));

      // Then perform the actual API call
      try {
        if (event.isFollowing) {
          await unfollowUser(event.username);
        } else {
          await followUser(event.username);
        }
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(ProfileLoaded(profile: currentProfile));
        emit(ProfileError(message: e.toString()));
      }
    }
  }
}