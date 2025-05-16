import 'dart:io';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';

abstract class CreatePostRemoteDataSource {
  Future<String> uploadImage(File image, Function(double) onProgress);
  Future<void> createPost(CreatePostEntity post);
  Future<List<String>> getSuggestedHashtags(String text);
  Future<List<String>> searchUsers(String query);
}

class CreatePostRemoteDataSourceImpl implements CreatePostRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock implementations

  @override
  Future<String> uploadImage(File image, Function(double) onProgress) async {
    // Simulate uploading progress
    for (double i = 0.1; i <= 1.0; i += 0.1) {
      await Future.delayed(const Duration(milliseconds: 200));
      onProgress(i);
    }

    // Return a mock image URL
    return 'https://picsum.photos/id/${DateTime.now().millisecondsSinceEpoch % 1000}/800/800';
  }

  @override
  Future<void> createPost(CreatePostEntity post) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, we would send the post data to the server
  }

  @override
  Future<List<String>> getSuggestedHashtags(String text) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate mock hashtag suggestions based on the text
    final List<String> suggestions = [];

    if (text.contains('food')) {
      suggestions.addAll(['foodie', 'foodporn', 'foodphotography', 'foodlover']);
    }

    if (text.contains('travel')) {
      suggestions.addAll(['travelphotography', 'travelgram', 'wanderlust', 'explore']);
    }

    if (text.contains('nature')) {
      suggestions.addAll(['naturephotography', 'naturelovers', 'outdoors', 'landscape']);
    }

    // Default suggestions if no matches
    if (suggestions.isEmpty) {
      suggestions.addAll(['instagram', 'photo', 'instagood', 'picoftheday', 'photography']);
    }

    return suggestions;
  }

  @override
  Future<List<String>> searchUsers(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock users based on the query
    if (query.isEmpty) {
      return [];
    }

    return [
      '${query}_user1',
      '${query}_user2',
      '${query}_enthusiast',
      '${query.toLowerCase()}_official',
      'the_${query.toLowerCase()}',
    ];
  }
}