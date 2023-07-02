import 'package:flutter/material.dart';
import 'package:trip_life/presentation/pages/friends_list_page.dart';
import 'package:trip_life/presentation/pages/home_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      const SizedBox(
        height: 70,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Trip Life',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
      ListTile(
          leading: const Icon(Icons.airplane_ticket),
          title: const Text('Voyages'),
          onTap: () {
            Navigator.of(context).pushReplacement(HomePage.route());
          }),
      ListTile(
          leading: const Icon(Icons.emoji_people),
          title: const Text('Amis'),
          onTap: () {
            Navigator.of(context).pushReplacement(FriendsListPage.route());
          }),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text('Paramètres'),
      )
    ]));
  }
}
