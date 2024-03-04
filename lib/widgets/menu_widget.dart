import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip_list.dart';
import 'package:provider_demo/model/track.dart';
import 'package:provider_demo/widgets/menu_item.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<AppModel>(
          builder: (context, appModel, child) {
            return MenuItem(
              text: "New",
              click: () {
                appModel.newProject();
              },
            );
          },
        ),
        Consumer<AppModel>(
          builder: (context, appModel, child) {
            return MenuItem(
              text: "New Track",
              click: () {
                Track track = Track();
                track.setName("New Track");

                appModel.addTrack(track);
              },
            );
          },
        ),
      ],
    );
  }
}
