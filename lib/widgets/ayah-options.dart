import 'package:flutter/material.dart';

class AyahOptions extends StatefulWidget {
  final IconData icon;
  const AyahOptions({Key key, this.icon}) : super(key: key);

  @override
  State<AyahOptions> createState() => _AyahOptionsState();
}

class _AyahOptionsState extends State<AyahOptions> {
  var isSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Icon(widget.icon),
        onTap: () {
          setState(() {
            this.isSelected = !this.isSelected;
            print("selected " + this.isSelected.toString());
          });
        },
      ),
    );
  }
}
