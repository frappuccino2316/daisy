import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  final String _title;

  PageAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
