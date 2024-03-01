import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/midi_model.dart';
import 'package:provider_demo/model/note.dart';
import 'package:provider_demo/model/timeline_bar.dart';
import 'package:provider_demo/views/note_view.dart';
import 'package:provider_demo/widgets/note_stage_bg_widget.dart';
import 'package:provider_demo/widgets/piano_bg_key.dart';
import 'package:provider_demo/widgets/timeline_bar_widget.dart';

class NoteStageView extends StatefulWidget {
  const NoteStageView({required this.height, required this.width, super.key});
  final double height;
  final double width;
  @override
  State<NoteStageView> createState() => _NoteStageViewState();
}

class _NoteStageViewState extends State<NoteStageView> {
  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(handleScroll);
  }

  handleScroll() {
    Provider.of<AppModel>(context, listen: false)
        .setNoteStageScrollOffset(scrollController.offset);
  }

  @override
  void dispose() {
    scrollController.removeListener(handleScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TimelineBarModel timelineBarModel = Provider.of(context);
    return SizedBox(
      height: widget.height - 300 > 0 ? widget.height - 300 : 200,
      width: widget.width,
      child: Column(
        children: [
          Consumer<AppModel>(builder: (context, appModel, child) {
            var clip = appModel
                .findTrackById(appModel.selectedTrackIndex)
                .findClipById(appModel.selectedClipId) as SingingClip;
            return SizedBox(
              height: 20,
              child: Row(
                children: [
                  Text(
                    clip.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  InkWell(
                    onTap: () async {
                      timelineBarModel.play(clip.notes);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Play"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      timelineBarModel.stop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Pause"),
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: widget.height - 322 > 0 ? widget.height - 322 : 178,
            width: widget.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        decoration: const BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.grey),
                        )),
                        child: const PianoBgKey(),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Consumer<AppModel>(
                              builder: (context, value, child) {
                                SingingClip singingClip = value
                                        .findTrackById(value.selectedTrackIndex)
                                        .findClipById(value.selectedClipId)
                                    as SingingClip;
                                return GestureDetector(
                                  onPanUpdate: (details) {},
                                  onPanDown: (details) {
                                    Note note = Note(
                                        noteKey: 102 -
                                            (details.localPosition.dy / 25)
                                                .floor(),
                                        start: details.localPosition.dx,
                                        y: (details.localPosition.dy / 25)
                                                    .floor() *
                                                25 +
                                            4);
                                    singingClip.insertNote(note);
                                    setState(() {});
                                  },
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                height: MidiModel.keys().length * 25,
                                width: widget.width - 40,
                                child: CustomPaint(
                                  painter: NoteStageBgPainter(
                                      keyHeight: 25,
                                      keyWidth: widget.width - 40),
                                  size: Size(widget.width,
                                      MidiModel.keys().length * 25),
                                ),
                              ),
                            ),
                            Consumer<AppModel>(
                              builder: (context, value, child) {
                                var clip = value
                                    .findTrackById(value.selectedTrackIndex)
                                    .findClipById(value.selectedClipId);
                                return SizedBox(
                                  height: MidiModel.keys().length * 25,
                                  width: widget.width - 40,
                                  child: Stack(
                                    children: clip.type == ClipType.singing
                                        ? (clip as SingingClip).notes.map((e) {
                                            return NoteView(note: e);
                                          }).toList()
                                        : [],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TimelineBarWidget(
                  height: widget.height,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
