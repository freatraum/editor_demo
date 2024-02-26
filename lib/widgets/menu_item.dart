import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({required this.text,this.click,super.key});
  final String text;
  final Function()? click;
  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool onHover = false;

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.click?.call();

      },
      
      onHover: (value) {
        setState(() {
          onHover=value;
        });
      },
      child: Container(
        height: 20,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onHover?Colors.grey[400]:Colors.grey
        ),
        child: Text(widget.text),
      ),
    );
  }
}