import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: const <Widget>[
      SizedBox(
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
        leading: Icon(Icons.airplane_ticket),
        title: Text('Voyages'),
      ),
      ListTile(
        leading: Icon(Icons.emoji_people),
        title: Text('Amis'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Paramètres'),
      )
    ]));
  }
}
