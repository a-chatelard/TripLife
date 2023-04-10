import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';
import 'package:trip_life/presentation/widgets/signin_page/signin_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SignInPage(title: "Connexion"));
  }

  final String title;

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SigninBloc(
            authenticationRepository:
                GetIt.I.get<AbstractAuthenticationRepository>()),
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const SigninForm(),
          ),
        ));
  }

  // Column buildColumn() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       TextField(
  //         controller: _controller,
  //         decoration: const InputDecoration(hintText: 'Enter name'),
  //       ),
  //       TextField(
  //         controller: _controller,
  //         decoration: const InputDecoration(hintText: 'Password'),
  //       ),
  //       ElevatedButton(
  //           onPressed: () {
  //             setState(() {
  //               _futureUser = createUser(_controller.text);
  //             });
  //           },
  //           child: const Text('Login In'))
  //     ],
  //   );
  // }

  // FutureBuilder<AppUser> buildFutureBuilder() {
  //   return FutureBuilder<AppUser>(
  //     future: _futureUser,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text(snapshot.data!.name);
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }

  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
}
