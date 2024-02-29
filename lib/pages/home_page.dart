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
                          return (appModel.selectedTrackIndex != -1 &&
                                  appModel.selectedClipId != -1)
                              ? SizedBox(
                                  height: constraints.maxHeight - 300 > 0
                                      ? constraints.maxHeight - 300
                                      : 200,
                                  width: constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      Consumer<AudioModel>(builder:
                                          (context, audioModel, child) {
                                        return SizedBox(
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Text(
                                                appModel
                                                    .findTrackById(appModel
                                                        .selectedTrackIndex)
                                                    .findClipById(
                                                        appModel.selectedClipId)
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const Text(
                                                "1",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // await audioModel.play();
                                                  await audioModel.play(60);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text("Play"),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // await audioModel.pause();
                                                  await audioModel.stop(60);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text("Pause"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      SizedBox(
                                        height: constraints.maxHeight - 322 > 0
                                            ? constraints.maxHeight - 322
                                            : 178,
                                        width: constraints.maxWidth,
                                        child: NoteStageView(
                                          height: constraints.maxHeight,
                                          width: constraints.maxWidth,
                                        ),
                                      )
                                    ],
                                  ),
                                )
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
