import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String username;
  final String fullName;
  final String profileImageUrl;
  final String bio;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final List<String> postImageUrls;
  final bool isCurrentUser;

  const ProfileEntity({
    required this.username,
    required this.fullName,
    required this.profileImageUrl,
    required this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.postImageUrls,
    required this.isCurrentUser,
  });

  // Add a copyWith method for easier state updates
  ProfileEntity copyWith({
    String? username,
    String? fullName,
    String? profileImageUrl,
    String? bio,
    int? postsCount,
    int? followersCount,
    int? followingCount,
    List<String>? postImageUrls,
    bool? isCurrentUser,
  }) {
    return ProfileEntity(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postImageUrls: postImageUrls ?? this.postImageUrls,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  @override
  List<Object> get props => [
    username,
    fullName,
    profileImageUrl,
    bio,
    postsCount,
    followersCount,
    followingCount,
    postImageUrls,
    isCurrentUser,
  ];
}