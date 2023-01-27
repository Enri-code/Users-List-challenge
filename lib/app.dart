import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';
import 'package:owwn_flutter_test/app/theme/theme_data.dart';
import 'package:owwn_flutter_test/core/constants/config.dart';
import 'package:owwn_flutter_test/core/constants/server_config.dart';
import 'package:owwn_flutter_test/core/utils/api_client.dart';
import 'package:owwn_flutter_test/features/auth/data/auth_repo.dart';
import 'package:owwn_flutter_test/features/auth/data/auth_service.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_service.dart';
import 'package:owwn_flutter_test/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:owwn_flutter_test/features/auth/presentation/screens/login_screen.dart';
import 'package:owwn_flutter_test/features/users_list/data/models/user.dart';
import 'package:owwn_flutter_test/features/users_list/data/repos/users_repo.dart';
import 'package:owwn_flutter_test/features/users_list/data/repos/users_service.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_service.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/bloc/users_bloc.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/screens/users_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: ApiClient(ServerConfig.apiBaseUrl),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthService>(
            create: (context) => AuthServiceImpl(context.read<ApiClient>()),
          ),
          RepositoryProvider<IUsersService>(
            create: (context) => UsersServiceImpl(context.read<ApiClient>()),
          ),
          RepositoryProvider<IAuthRepo>(
            create: (context) => AuthRepoImpl(context.read<IAuthService>()),
          ),
          RepositoryProvider<IUsersRepo>(
            create: (context) => UsersRepoImpl(
              service: context.read<IUsersService>(),
              converter: UserModel.fromMap,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(context.read<IAuthRepo>()),
            ),
            BlocProvider(
              create: (context) => UsersBloc(context.read<IUsersRepo>()),
            ),
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (prev, curr) => prev.isSignedIn != curr.isSignedIn,
            listener: (context, state) {
              //Navigate user to respective route depending on new signed in state
              if (state.isSignedIn) {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  UsersScreen.routeName,
                  (_) => false,
                );
              } else {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (_) => false,
                );
              }
            },
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: AppConfig.appName,
              routes: AppConfig.appRoutes,
              initialRoute: LoginScreen.routeName,
              darkTheme: DarkThemeProvider(ColorPalette.primaryColor).theme,
              themeMode: ThemeMode.dark,
            ),
          ),
        ),
      ),
    );
  }
}
