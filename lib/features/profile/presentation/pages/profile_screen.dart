import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/post_detail/presentation/pages/post_detail_screen.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_event.dart';
import 'package:instagram_clone/features/profile/presentation/bloc/profile_state.dart';
import 'package:instagram_clone/di.dart';
import 'package:instagram_clone/utils/app_extension.dart';
import 'package:instagram_clone/utils/app_images.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, this.username = ''});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<ProfileBloc>()..add(LoadProfileEvent(username: username)),
      child: BlocBuilder<ProfileBloc, BaseApiState>(
        builder: (context, state) {
          final apiStatus = state.toApiStatus(); // Convert state to MyApiStatus

          return Scaffold(
            appBar: AppBar(
              title: BlocBuilder<ProfileBloc, BaseApiState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return Text(state.profile.username);
                  }
                  return const Text('Profile');
                },
              ),
              actions: [
                SvgPicture.asset(AppImages.addReel),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Show menu options
                  },
                ),
              ],
            ),
            body: MyWidgetsAnimator(
              hideSuccessWidgetWhileRefreshing: false,
              apiCallStatus: apiStatus, // Use MyApiStatus directly
              holdingWidget:
                  () => const Center(child: CircularProgressIndicator()),
              loadingWidget: () => Center(child: CircularProgressIndicator()),
              errorWidget:
                  (message) =>
                      Center(child: Text("Error occurred! ${message}")),
              emptyWidget:
                  () => const Center(child: Text("No data available.")),
              refreshWidget:
                  () => const Center(child: CircularProgressIndicator()),
              successWidget: () {
                ProfileLoaded successState = state as ProfileLoaded;
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB( 16,10,16,16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:160,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundImage: NetworkImage(
                                          successState.profile.profileImageUrl,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 100,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6,horizontal: 14),
                                          // padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                              color: AppTheme.darkDividerColor),
                                          child: TextCustom(text:'Share a \n note',textAlign: TextAlign.center,fontSize: 14,color: AppTheme.darkTextColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        successState.profile.fullName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ).paddingBottom(8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildStatColumn(
                                            successState.profile.postsCount,
                                            'Posts',
                                          ),
                                          _buildStatColumn(
                                            successState.profile.followersCount,
                                            'Followers',
                                          ),
                                          _buildStatColumn(
                                            successState.profile.followingCount,
                                            'Following',
                                          ),
                                        ],
                                      ).paddingEnd(18),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            if (successState.profile.bio.isNotEmpty)
                              Text(successState.profile.bio),
                            const SizedBox(height: 12),
                            _buildActionButton(context, successState.profile),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        // Generate unique postId based on index
                        final postId = (10 + index).toString();
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(postId: postId),
                              ),
                            );
                          },
                          child: Image.network(
                            successState.profile.postImageUrls[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        );
                      }, childCount: successState.profile.postImageUrls.length),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(int count, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, profile) {
    if (profile.isCurrentUser) {
      return Row(
        children: [
          Expanded(
            flex: 7,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to edit profile
              },
              child: const Text(
                 'Edit Profile',
              ),
            ).paddingEnd(8),
          ),
          Expanded(
            flex: 7,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to edit profile
              },
              child: const Text('Edit Profile'),
            ).paddingEnd(8),
          ),
        ],
      );
    } else {
      // Follow/Unfollow button for other users
      final isFollowing = false; // This would come from the state in a real app
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<ProfileBloc>().add(
              ToggleFollowEvent(
                username: profile.username,
                isFollowing: isFollowing,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isFollowing ? Colors.grey[200] : Theme.of(context).primaryColor,
            foregroundColor: isFollowing ? Colors.black : Colors.white,
          ),
          child: Text(isFollowing ? 'Unfollow' : 'Follow'),
        ),
      );
    }
  }
}
