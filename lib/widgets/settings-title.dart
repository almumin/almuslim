import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  final IconData icon;
  final String headingText;
  final bool hasBorder;
  final Function onTap;

  static const double fontSize = 15;

  SettingsTitle({Key key, this.icon, this.headingText, this.hasBorder, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderSide currentBorder = getBorder(this.hasBorder);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 12),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: currentBorder,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: fontSize,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        headingText,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: fontSize,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  BorderSide getBorder(bool hasBorder) {
    if (hasBorder) {
      return BorderSide(
        color: Colors.black38,
        width: 1.0,
      );
    }
    return BorderSide(
      color: Colors.transparent,
    );
  }
}
