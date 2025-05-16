import 'package:instagram_clone/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.username,
    required super.fullName,
    required super.profileImageUrl,
    required super.bio,
    required super.postsCount,
    required super.followersCount,
    required super.followingCount,
    required super.postImageUrls,
    required super.isCurrentUser,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      postsCount: json['postsCount'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      postImageUrls: List<String>.from(json['postImageUrls']),
      isCurrentUser: json['isCurrentUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'postsCount': postsCount,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postImageUrls': postImageUrls,
      'isCurrentUser': isCurrentUser,
    };
  }
}