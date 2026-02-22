import 'package:flutter/material.dart';
import 'package:livechat/livechat_view.dart';

void main() {
  runApp(const LivechatApp());
}

class LivechatApp extends StatelessWidget {
  const LivechatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livechat',
      home: const LivechatView(host: '192.168.100.97'),
    );
  }
}
