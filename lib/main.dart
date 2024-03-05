import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/audio_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/clip_list.dart';
import 'package:provider_demo/model/drag_action_model.dart';
import 'package:provider_demo/model/timeline_bar.dart';
import 'package:provider_demo/model/track.dart';
import 'package:provider_demo/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => AppModel()),
        ChangeNotifierProvider<Track>(create: (_) => Track()),
        ChangeNotifierProvider<DragActionModel>(
          create: (_) => DragActionModel(),
        ),
        FutureProvider<AudioModel>(
            create: (context) {
              return Future.value(AudioModel());
            },
            initialData: AudioModel()),
        ChangeNotifierProxyProvider<AudioModel, TimelineBarModel>(
          create: (_) =>
              TimelineBarModel(AudioModel().play, AudioModel().stopAll),
          update: (context, value, previous) =>
              TimelineBarModel(AudioModel().play, AudioModel().stopAll),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
