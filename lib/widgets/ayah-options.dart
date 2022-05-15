import 'package:flutter/material.dart';

class AyahOptions extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final Color selectionColor;
  const AyahOptions({Key key, this.icon, this.isSelected, this.selectionColor}) : super(key: key);

  @override
  State<AyahOptions> createState() => _AyahOptionsState();
}

class _AyahOptionsState extends State<AyahOptions> {
  var selected;

  @override
  void initState() {
    super.initState();
    selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Icon(
          widget.icon,
          color: this.selected ? widget.selectionColor : Colors.grey.shade500,
        ),
        onTap: () {
          setState(() {
            this.selected = !this.selected;
            print("selected " + this.selected.toString());
          });
        },
      ),
    );
  }
}
