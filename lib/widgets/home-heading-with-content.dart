import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeadingWidget extends StatelessWidget {
  final String headingTitle;
  final Widget widgets;
  final IconData icon;

  const HomeHeadingWidget({
    Key key,
    this.headingTitle,
    this.widgets,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
          /*border: Border.all(
              color: Colors.black12,
              width: 1.0,
            )*/
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 19,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      headingTitle,
                      style: TextStyle(color: Colors.green, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: widgets,
            )
          ],
        ),
      ),
    );
  }
}
