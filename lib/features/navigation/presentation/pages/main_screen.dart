import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:instagram_clone/features/activity/presentation/pages/activity_screen.dart';
import 'package:instagram_clone/features/create_post/presentation/pages/image_picker_screen.dart';
import 'package:instagram_clone/features/feed/presentation/pages/feed_screen.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_state.dart';
import 'package:instagram_clone/features/profile/presentation/pages/profile_screen.dart';
import 'package:instagram_clone/features/reels/presentation/pages/reels_screen.dart';
import 'package:instagram_clone/features/search/presentation/pages/search_screen.dart';
import 'package:instagram_clone/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:instagram_clone/features/theme/presentation/bloc/theme_event.dart';
import 'package:instagram_clone/di.dart';
import 'package:instagram_clone/utils/app_images.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => sl<NavigationBloc>(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: const [
                FeedScreen(),
                SearchScreen(),
                ImagePickerScreen(),
                ReelsScreen(),
                ProfileScreen(), // Current user profile
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor:
                  Theme.of(
                    context,
                  ).bottomNavigationBarTheme.unselectedItemColor,
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<NavigationBloc>().add(ChangeTabEvent(index));
              },
              items:  [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.home),
                  activeIcon: SvgPicture.asset(AppImages.homeActive),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.search),
                  activeIcon: SvgPicture.asset(AppImages.searchActive),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.addReel),
                  activeIcon: SvgPicture.asset(AppImages.addReel),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.reels),
                  activeIcon: SvgPicture.asset(AppImages.reels),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: '',
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
            // Theme toggle button (for testing, we'll move this to settings later)
            /*floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
              mini: true,
              child: const Icon(Icons.brightness_6),
            ),*/
          );
        },
      ),
    );
  }
}
