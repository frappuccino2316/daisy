import 'package:flutter/material.dart';

import '../components/page_app_bar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar('設定'),
      body: const Center(
        child: Text('Setting'),
      ),
    );
  }
}
