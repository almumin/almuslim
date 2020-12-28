import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function onTapRun;

  const HomeIcon({
    Key key,
    this.iconPath,
    this.text, this.onTapRun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "assets/icons/" + iconPath,
                height: 70,
                width: 70,
                fit: BoxFit.fitWidth,
              ),
              Text(text)
            ],
          ),
        ),
      ),
      onTap: onTapRun,
    );
  }
}
