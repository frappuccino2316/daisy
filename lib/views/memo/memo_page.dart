import 'package:flutter/material.dart';

import '../components/page_app_bar.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar('メモ'),
      body: const Center(
        child: Text('Memo'),
      ),
    );
  }
}
