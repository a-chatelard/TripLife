import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';
import 'package:trip_life/presentation/widgets/signin/signin_form.dart';

void main() {}
// void main() {
//   testWidgets('Signin page test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.

//     GetIt serviceLocator = GetIt.instance;

//     serviceLocator.registerSingleton<AbstractAuthenticationRepository>(
//         MockAbstractAuthenticationRepository(),
//         signalsReady: true);

//     // Widget testWidget = const MediaQuery(
//     //     data: MediaQueryData(),
//     //     child: MaterialApp(
//     //         home: SingleChildScrollView(
//     //             child: SignInPage(
//     //       title: 'Connexion',
//     //     ))));

//     Widget testWidget = MaterialApp(
//         home: BlocProvider(
//             create: (_) => SigninBloc(
//                 authenticationRepository:
//                     serviceLocator.get<AbstractAuthenticationRepository>()),
//             child: const SigninForm()));

//     await tester.pumpWidget(testWidget);

//     //expect(find.text("Email"), findsOneWidget);

//     await tester.enterText(find.byType(TextFormField), "test@test.fr");
//     await tester.tap(find.byType(ElevatedButton));

//     expect(find.text('Veuillez saisir un mot de passe'), findsOneWidget);

//     // // Verify that our counter starts at 0.
//     // expect(find.text('0'), findsOneWidget);
//     // expect(find.text('1'), findsNothing);

//     // // Tap the '+' icon and trigger a frame.
//     // await tester.tap(find.byIcon(Icons.add));
//     // await tester.pump();

//     // // Verify that our counter has incremented.
//     // expect(find.text('0'), findsNothing);
//     // expect(find.text('1'), findsOneWidget);
//   });
// }
