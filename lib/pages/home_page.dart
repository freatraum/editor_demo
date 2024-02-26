import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppModel>(builder: (context, appModel, child) => Text(appModel.projectName),),
        centerTitle: true,
        toolbarHeight: 30,
        leading: Row(
          children: [Container(
            child: Text("New"),
          )],
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}