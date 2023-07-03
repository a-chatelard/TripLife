import 'package:flutter/material.dart';

class RetryScaffold extends StatelessWidget {
  const RetryScaffold({super.key, required this.callback, this.errorMessage});

  final String? errorMessage;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(errorMessage ?? "Une erreur est survenue."),
            const Divider(
                height: 20,
                indent: 20,
                endIndent: 0,
                color: Colors.transparent),
            TextButton(
              onPressed: callback,
              child: const Text("Réessayer"),
            )
          ],
        ),
      ),
    );
  }
}
