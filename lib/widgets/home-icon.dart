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
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(width * .05),
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "assets/icons/" + iconPath,
                height: 70,
                width: width * .58 / 4,
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
