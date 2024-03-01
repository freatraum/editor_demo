import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/timeline_bar.dart';

import 'package:provider_demo/res.dart';

class TimelineBarWidget extends StatefulWidget {
  const TimelineBarWidget({required this.height, super.key});
  final double height;
  @override
  State<TimelineBarWidget> createState() => _TimelineBarWidgetState();
}

class _TimelineBarWidgetState extends State<TimelineBarWidget> {
  @override
  Widget build(BuildContext context) {
    TimelineBarModel model = Provider.of<TimelineBarModel>(context);

    return Selector<TimelineBarModel, int>(
      builder: (context, value, child) {
        return Positioned(
          left: model.currentPos + 30,
          child: child!,
        );
      },
      selector: (ctx, timelineBarModel) => timelineBarModel.currentPos,
      child: SizedBox(
        height: widget.height,
        width: 40,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                Res.tri,
                height: 15,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 12,
              left: 9,
              child: Container(
                height: widget.height - 15,
                width: 2,
                color: Colors.lightBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
