import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:trip_life/presentation/pages/home_page.dart';
import 'package:trip_life/presentation/pages/signin_page.dart';
import 'package:trip_life/presentation/pages/splash_page.dart';
import 'package:trip_life/presentation/service_locator.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(
          authenticationRepository:
              serviceLocator.get<AbstractAuthenticationRepository>(),
          friendRepository: serviceLocator.get<AbstractFriendRepository>()),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    SignInPage.route(), (route) => false);
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      // theme: ThemeData(
      //   primaryColor:
      //       const Color(0xFF2980b9), // une couleur jaune qui rappelle le soleil
      //   scaffoldBackgroundColor: const Color(
      //       0xFFecf0f1), // une couleur gris clair qui rappelle le sable
      //   fontFamily: 'Montserrat', // une police moderne et élégante
      //   textTheme: const TextTheme(
      //     displayLarge: TextStyle(
      //         fontSize: 28.0,
      //         fontWeight:
      //             FontWeight.bold), // une police en gras pour les titres
      //     bodyLarge:
      //         TextStyle(fontSize: 18.0), // une police pour le texte principal
      //     labelLarge: TextStyle(
      //         fontSize: 20.0,
      //         fontWeight: FontWeight.bold), // une police pour les boutons
      //   ),
      //   appBarTheme: const AppBarTheme(
      //     color: Colors
      //         .transparent, // une barre d'applications transparente pour laisser les images en arrière-plan apparaître
      //     elevation: 0.0, // pas d'ombre pour la barre d'applications
      //     iconTheme: IconThemeData(
      //         color: Colors
      //             .white), // les icônes de la barre d'applications sont en blanc
      //     toolbarTextStyle: TextStyle(
      //         fontSize: 20.0,
      //         fontWeight: FontWeight.bold,
      //         color: Colors
      //             .white), // une police pour le texte dans la barre d'applications en blanc
      //   ),

      //   colorScheme: ColorScheme.fromSwatch()
      //       .copyWith(secondary: const Color(0xFFf1c40f)),
      // ),
    );
  }
}
