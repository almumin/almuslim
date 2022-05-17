import 'package:flutter/material.dart';

import '../database/store.dart';
import '../models/quran-entity.dart';
import '../objectbox.g.dart';

class AyahOptions extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final Color selectionColor;
  final ObjectBox objectBox;
  final String optionType;
  final int id;
  const AyahOptions({Key key, this.icon, this.isSelected, this.selectionColor, this.objectBox, this.optionType, this.id}) : super(key: key);

  @override
  State<AyahOptions> createState() => _AyahOptionsState();
}

class _AyahOptionsState extends State<AyahOptions> {
  var selected;
  Box quranObjectBox;
  QuranAyah currentAyah;

  @override
  void initState() {
    super.initState();
    selected = widget.isSelected;
    quranObjectBox = widget.objectBox.store.box<QuranAyah>();
    currentAyah = quranObjectBox.get(widget.id);
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
            if (widget.optionType != null){
              switch (widget.optionType) {
                case "favorite":
                  currentAyah.isFavorite = this.selected;
                  break;
                case "readAlready":
                  currentAyah.readAlready = this.selected;
                  break;
              }
              quranObjectBox.put(currentAyah);
            }
            print("selected " + this.selected.toString());
          });
        },
      ),
    );
  }
}
