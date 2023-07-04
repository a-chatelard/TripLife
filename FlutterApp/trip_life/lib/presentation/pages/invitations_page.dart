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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          title: widget.title,
          tabBar: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.people),
              ),
              Tab(
                icon: Icon(Icons.airplane_ticket),
              ),
            ],
          ),
        ),
        drawer: const MainDrawer(),
        body: const TabBarView(
          children: <Widget>[FriendInvitationList(), VacationInvitationList()],
        ),
      ),
    );
  }
}
