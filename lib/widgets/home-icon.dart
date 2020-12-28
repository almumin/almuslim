import 'package:flutter/cupertino.dart';

class HomeIcon extends StatelessWidget {
  final String iconPath;
  final String text;

  const HomeIcon({
    Key key,
    this.iconPath,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
