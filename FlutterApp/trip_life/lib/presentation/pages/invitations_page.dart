import 'package:flutter/material.dart';
import 'package:trip_life/presentation/widgets/invitations/friend_invitation_list.dart';
import 'package:trip_life/presentation/widgets/invitations/vacation_invitation_list.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';

class InvitationsPage extends StatefulWidget {
  const InvitationsPage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const InvitationsPage(title: "Invitations"));
  }

  final String title;

  @override
  State<InvitationsPage> createState() => _InvitationsPageState();
}

class _InvitationsPageState extends State<InvitationsPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FriendInvitationList(),
    VacationInvitationList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Amis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Voyages',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
