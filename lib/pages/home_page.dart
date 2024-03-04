import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/audio_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/views/note_stage_view.dart';
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
                  Consumer<AppModel>(
                    builder: (context, appModel, child) =>
                        Text(appModel.projectName),
                  ),
                  Container()
                ],
              ),
            ),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Consumer<AppModel>(
                        builder: (context, appModel, child) {
                          return SingleChildScrollView(
                            child: Column(
                              children: appModel.tracks.map((e) {
                                return TrackView(
                                  track: e,
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight - 300 > 0
                          ? constraints.maxHeight - 300
                          : 200,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black, width: 2))),
                      child: Consumer<AppModel>(
                        builder: (context, appModel, child) {
                          return (appModel.selectedTrackId != -1 &&
                                  appModel.selectedClipId != -1)
                              ? NoteStageView(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth)
                              : Container();
                        },
                      ),
                    )
                  ],
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
