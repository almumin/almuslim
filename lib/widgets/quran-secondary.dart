import 'package:almuslim/database/store.dart';
import 'package:almuslim/objectbox.g.dart';
import 'package:flutter/material.dart';

import '../models/quran-entity.dart';

class QuranSecondary extends StatefulWidget {
  final ObjectBox objectBox;

  const QuranSecondary({Key key, this.objectBox}) : super(key: key);

  @override
  State<QuranSecondary> createState() => _QuranSecondaryState();
}

class _QuranSecondaryState extends State<QuranSecondary> {
  @override
  Widget build(BuildContext context) {
    var userBox = widget.objectBox.store.box<QuranAyah>();
    final query = (userBox.query(QuranAyah_.id.between(8, 300))
          ..order(QuranAyah_.id))
        .build();
    final results = query.find();
    print(results.length);
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (_, int index) {
          return Column(
            children: [
              Text(results[index].arabicText),
              Text(results[index].englishTranslation),
            ],
          );
        });
  }
}
