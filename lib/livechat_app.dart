import 'package:flutter/material.dart';
import 'package:livechat/livechat_view.dart';
import 'package:livechat/signaling.dart';
import 'package:livechat/signaling_impl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Signaling>(
          create: (context) => SignalingImpl('192.168.100.97', context),
        ),
      ],
      child: const LivechatApp(),
    ),
  );
}

class LivechatApp extends StatelessWidget {
  const LivechatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Livechat', home: const LivechatView());
  }
}
