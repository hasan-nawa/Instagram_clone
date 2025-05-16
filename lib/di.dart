import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:instagram_clone/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:instagram_clone/features/activity/domain/repositories/activity_repository.dart';
import 'package:instagram_clone/features/activity/domain/usecases/get_earlier_activity.dart';
import 'package:instagram_clone/features/activity/domain/usecases/get_recent_activity.dart';
import 'package:instagram_clone/features/activity/domain/usecases/mark_all_as_read.dart';
import 'package:instagram_clone/features/activity/domain/usecases/mark_as_read.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:instagram_clone/features/create_post/data/datasources/create_post_remote_data_source.dart';
import 'package:instagram_clone/features/create_post/data/repositories/create_post_repository_impl.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/create_post.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/get_suggested_hashtags.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/search_users.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/upload_image.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_bloc.dart';
import 'package:instagram_clone/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:instagram_clone/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';
import 'package:instagram_clone/features/feed/domain/usecases/bookmark_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/get_posts.dart';
import 'package:instagram_clone/features/feed/domain/usecases/like_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/unbookmark_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/unlike_post.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:instagram_clone/features/post_detail/data/datasources/post_detail_remote_data_source.dart';
import 'package:instagram_clone/features/post_detail/data/repositories/post_detail_repository_impl.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/add_comment.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/bookmark_post.dart' as post_detail;
import 'package:instagram_clone/features/post_detail/domain/usecases/get_post_by_id.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/like_post.dart' as post_detail;
import 'package:instagram_clone/features/post_detail/domain/usecases/unbookmark_post.dart' as post_detail;
import 'package:instagram_clone/features/post_detail/domain/usecases/unlike_post.dart' as post_detail;
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_bloc.dart';
import 'package:instagram_clone/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:instagram_clone/features/profile/domain/repositories/profile_repository.dart';
import 'package:instagram_clone/features/profile/domain/usecases/follow_user.dart';
import 'package:instagram_clone/features/profile/domain/usecases/get_user_profile.dart';
import 'package:instagram_clone/features/profile/domain/usecases/unfollow_user.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:instagram_clone/features/search/data/datasources/search_remote_data_source.dart';
import 'package:instagram_clone/features/search/data/repositories/search_repository_impl.dart';
import 'package:instagram_clone/features/search/domain/repositories/search_repository.dart';
import 'package:instagram_clone/features/search/domain/usecases/get_explore_content.dart';
import 'package:instagram_clone/features/search/domain/usecases/search.dart';
import 'package:instagram_clone/features/search/presentation/bloc/search_bloc.dart';
import 'package:instagram_clone/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:instagram_clone/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:instagram_clone/features/theme/domain/repositories/theme_repository.dart';
import 'package:instagram_clone/features/theme/domain/usecases/get_current_theme.dart';
import 'package:instagram_clone/features/theme/domain/usecases/set_theme.dart';
import 'package:instagram_clone/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:instagram_clone/features/reels/data/datasources/reels_remote_data_source.dart';
import 'package:instagram_clone/features/reels/data/repositories/reels_repository_impl.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';
import 'package:instagram_clone/features/reels/domain/usecases/bookmark_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/follow_user.dart' as reel;
import 'package:instagram_clone/features/reels/domain/usecases/get_reels.dart';
import 'package:instagram_clone/features/reels/domain/usecases/increase_share_count.dart';
import 'package:instagram_clone/features/reels/domain/usecases/like_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/unbookmark_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/unfollow_user.dart' as reel;
import 'package:instagram_clone/features/reels/domain/usecases/unlike_reel.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Feature: Theme
  // Data sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
        () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ThemeRepository>(
        () => ThemeRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentTheme(sl()));
  sl.registerLazySingleton(() => SetTheme(sl()));

  // BLoCs
  sl.registerFactory(
        () => ThemeBloc(
      getCurrentTheme: sl(),
      setTheme: sl(),
    ),
  );

  // Feature: Navigation
  sl.registerFactory(() => NavigationBloc());

  // Feature: Feed
  // Data sources
  sl.registerLazySingleton<FeedRemoteDataSource>(
        () => FeedRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<FeedRepository>(
        () => FeedRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => LikePost(sl()));
  sl.registerLazySingleton(() => UnlikePost(sl()));
  sl.registerLazySingleton(() => BookmarkPost(sl()));
  sl.registerLazySingleton(() => UnbookmarkPost(sl()));

  // BLoCs
  sl.registerFactory(
        () => FeedBloc(
      getPosts: sl(),
      likePost: sl(),
      unlikePost: sl(),
      bookmarkPost: sl(),
      unbookmarkPost: sl(),
    ),
  );

  // Feature: Profile
  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => FollowUser(sl()));
  sl.registerLazySingleton(() => UnfollowUser(sl()));

  // BLoCs
  sl.registerFactory(
        () => ProfileBloc(
      getUserProfile: sl(),
      followUser: sl(),
      unfollowUser: sl(),
    ),
  );

  // Feature: Post Detail
  // Data sources
  sl.registerLazySingleton<PostDetailRemoteDataSource>(
        () => PostDetailRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<PostDetailRepository>(
        () => PostDetailRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPostById(sl()));
  sl.registerLazySingleton(() => post_detail.LikePost(sl()));
  sl.registerLazySingleton(() => post_detail.UnlikePost(sl()));
  sl.registerLazySingleton(() => post_detail.BookmarkPost(sl()));
  sl.registerLazySingleton(() => post_detail.UnbookmarkPost(sl()));
  sl.registerLazySingleton(() => AddComment(sl()));

  // BLoCs
  sl.registerFactory(
        () => PostDetailBloc(
      getPostById: sl(),
      likePost: sl(),
      unlikePost: sl(),
      bookmarkPost: sl(),
      unbookmarkPost: sl(),
      addComment: sl(),
    ),
  );

  // Feature: Search
  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => Search(sl()));
  sl.registerLazySingleton(() => GetExploreContent(sl()));

  // BLoCs
  sl.registerFactory(
        () => SearchBloc(
      search: sl(),
      getExploreContent: sl(),
    ),
  );

  // Feature: Activity
  // Data sources
  sl.registerLazySingleton<ActivityRemoteDataSource>(
        () => ActivityRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ActivityRepository>(
        () => ActivityRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRecentActivity(sl()));
  sl.registerLazySingleton(() => GetEarlierActivity(sl()));
  sl.registerLazySingleton(() => MarkAsRead(sl()));
  sl.registerLazySingleton(() => MarkAllAsRead(sl()));

  // BLoCs
  sl.registerFactory(
        () => ActivityBloc(
      getRecentActivity: sl(),
      getEarlierActivity: sl(),
      markAsRead: sl(),
      markAllAsRead: sl(),
    ),
  );

  // Feature: Create Post
  // Data sources
  sl.registerLazySingleton<CreatePostRemoteDataSource>(
        () => CreatePostRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<CreatePostRepository>(
        () => CreatePostRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => UploadImage(sl()));
  sl.registerLazySingleton(() => CreatePost(sl()));
  sl.registerLazySingleton(() => GetSuggestedHashtags(sl()));
  sl.registerLazySingleton(() => SearchUsers(sl()));

  // BLoCs
  sl.registerFactory(
        () => CreatePostBloc(
      uploadImage: sl(),
      createPost: sl(),
      getSuggestedHashtags: sl(),
      searchUsers: sl(),
    ),
  );

  // Feature: Reels
  // Data sources
  sl.registerLazySingleton<ReelsRemoteDataSource>(
        () => ReelsRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ReelsRepository>(
        () => ReelsRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetReels(sl()));
  sl.registerLazySingleton(() => LikeReel(sl()));
  sl.registerLazySingleton(() => UnlikeReel(sl()));
  sl.registerLazySingleton(() => BookmarkReel(sl()));
  sl.registerLazySingleton(() => UnbookmarkReel(sl()));
  sl.registerLazySingleton(() => reel.FollowUser(sl()));
  sl.registerLazySingleton(() => reel.UnfollowUser(sl()));
  sl.registerLazySingleton(() => IncreaseShareCount(sl()));

  // BLoCs
  sl.registerFactory(
        () => ReelsBloc(
      getReels: sl(),
      likeReel: sl(),
      unlikeReel: sl(),
      bookmarkReel: sl(),
      unbookmarkReel: sl(),
      followUser: sl(),
      unfollowUser: sl(),
      increaseShareCount: sl(),
    ),
  );

}