import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required List<UserEntity> users,
    required List<HashtagEntity> hashtags,
    required List<PostPreviewEntity> topPosts,
  }) : super(
    users: users,
    hashtags: hashtags,
    topPosts: topPosts,
  );

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      users: (json['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList(),
      hashtags: (json['hashtags'] as List)
          .map((hashtag) => HashtagModel.fromJson(hashtag))
          .toList(),
      topPosts: (json['topPosts'] as List)
          .map((post) => PostPreviewModel.fromJson(post))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((user) {
        if (user is UserModel) {
          return user.toJson();
        }
        return {};
      }).toList(),
      'hashtags': hashtags.map((hashtag) {
        if (hashtag is HashtagModel) {
          return hashtag.toJson();
        }
        return {};
      }).toList(),
      'topPosts': topPosts.map((post) {
        if (post is PostPreviewModel) {
          return post.toJson();
        }
        return {};
      }).toList(),
    };
  }
}

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String username,
    required String fullName,
    required String profileImageUrl,
    required bool isVerified,
    required bool isFollowing,
  }) : super(
    id: id,
    username: username,
    fullName: fullName,
    profileImageUrl: profileImageUrl,
    isVerified: isVerified,
    isFollowing: isFollowing,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      isVerified: json['isVerified'],
      isFollowing: json['isFollowing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
      'isVerified': isVerified,
      'isFollowing': isFollowing,
    };
  }
}

class HashtagModel extends HashtagEntity {
  const HashtagModel({
    required String name,
    required int postsCount,
  }) : super(
    name: name,
    postsCount: postsCount,
  );

  factory HashtagModel.fromJson(Map<String, dynamic> json) {
    return HashtagModel(
      name: json['name'],
      postsCount: json['postsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'postsCount': postsCount,
    };
  }
}

class PostPreviewModel extends PostPreviewEntity {
  const PostPreviewModel({
    required String id,
    required String imageUrl,
    required int likesCount,
    required int commentsCount,
  }) : super(
    id: id,
    imageUrl: imageUrl,
    likesCount: likesCount,
    commentsCount: commentsCount,
  );

  factory PostPreviewModel.fromJson(Map<String, dynamic> json) {
    return PostPreviewModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }
}