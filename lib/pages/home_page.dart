import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/views/track_view.dart';
import 'package:provider_demo/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 26,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MenuWidget(),
                  Consumer<AppModel>(builder: (context, appModel, child) => Text(appModel.projectName),),
                  Container()
                ],
              ),
            ),
            Expanded(child: Consumer<AppModel>(
              builder: (context, appModel, child) {
                return Column(
                  children: appModel.tracks.map((e){
                    return TrackView(track: e,);
                  }).toList(),
                );
              },
              
            ))
          ],
        ),
      ),
    );
  }
}