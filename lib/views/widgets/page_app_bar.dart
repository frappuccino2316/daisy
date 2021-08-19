import 'package:flutter/material.dart';

class PageAppBar extends StatefulWidget with PreferredSizeWidget {
  final String _title;

  PageAppBar(this._title);

  @override
  _PageAppBarState createState() => _PageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PageAppBarState extends State<PageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget._title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
