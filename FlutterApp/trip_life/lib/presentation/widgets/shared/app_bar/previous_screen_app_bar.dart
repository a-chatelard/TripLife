import 'package:flutter/material.dart';

class PreviousScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PreviousScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
