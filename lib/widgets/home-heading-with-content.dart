import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeadingWidget extends StatelessWidget {
  final String headingTitle;
  const HomeHeadingWidget({
    Key key,
    this.headingTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_circle_outline,
                  size: 18,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  headingTitle,
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups",
              ),
            )
          ],
        ),
      ),
    );
  }
}
