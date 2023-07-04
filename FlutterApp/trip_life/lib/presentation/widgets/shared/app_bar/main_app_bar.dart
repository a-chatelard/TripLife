import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    this.tabBar,
  });

  final String title;
  final TabBar? tabBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      bottom: tabBar,
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<AuthenticationBloc>().add(LogOutUserAuthentication());
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
