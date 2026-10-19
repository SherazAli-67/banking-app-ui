import 'package:banking_app/constants/animation_constant.dart';
import 'package:banking_app/presentation/providers/add_money_provider.dart';
import 'package:banking_app/presentation/providers/home_provider.dart';
import 'package:banking_app/presentation/screens/add_money_screen.dart';
import 'package:banking_app/presentation/screens/home_screen.dart';
import 'package:banking_app/presentation/screens/main_shell.dart';
import 'package:banking_app/presentation/screens/map_screen.dart';
import 'package:banking_app/presentation/screens/profile_screen.dart';
import 'package:banking_app/presentation/screens/settings_screen.dart';
import 'package:banking_app/presentation/screens/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) => MainShell(navigationShell: navigationShell,),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.home.routeName,
              builder: (ctx, state) => ChangeNotifierProvider(create: (_) => HomeProvider(), child: const HomeScreen(),),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.map.routeName, builder: (ctx, state) => const MapScreen(),),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.transfer.routeName, builder: (ctx, state) => const TransferScreen(),),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.settings.routeName, builder: (ctx, state) => const SettingsScreen(),),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.profile.routeName, builder: (ctx, state) => const ProfileScreen(),),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: NamedRoutes.addMoney.routeName,
      pageBuilder: (ctx, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: AnimationConstant.entrance,
        reverseTransitionDuration: AnimationConstant.interaction,
        child: ChangeNotifierProvider(
          create: (_) => AddMoneyProvider(),
          child: const AddMoneyScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    ),

  ],
);

enum NamedRoutes {
  home('/home'),
  map('/map'),
  transfer('/transfer'),
  settings('/settings'),
  profile('/profile'),
  addMoney('/add-money');

  final String routeName;
  const NamedRoutes(this.routeName);
}
