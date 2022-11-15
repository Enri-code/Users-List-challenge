import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/features/auth/presentation/screens/login_screen.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/screens/user_profile.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/screens/users_screen.dart';

///Global class containing const variables for the application
/// used across the project
abstract class AppConfig {
  AppConfig._();

  ///The one-line description used to represent the app (Android and Web)
  static const appName = 'OWWN Coding Challenge';

  static final appRoutes = <String, WidgetBuilder>{
    LoginScreen.routeName: (_) => const LoginScreen(),
    UsersScreen.routeName: (_) => const UsersScreen(),
    UserProfileScreen.routeName: (_) => const UserProfileScreen(),
  };
}
