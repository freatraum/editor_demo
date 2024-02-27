import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/track.dart';
import 'package:provider_demo/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_)=>AppModel()),
        ChangeNotifierProvider<Track>(create: (_)=>Track()),
        ChangeNotifierProvider<Clip>(create: (_)=>Clip())
        // ChangeNotifierProxyProvider<Track,AppModel>(create: (_)=>AppModel(), 
        //   update: (context, value, previous) => AppModel(),
        // )
        // ChangeNotifierProxyProvider<AppModel,Track>(create: (_)=>AppModel(), update: update)
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

