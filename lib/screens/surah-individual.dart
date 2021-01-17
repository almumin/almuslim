import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:almuslim/widgets/surah-individual-content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahIndividual extends StatefulWidget {
  final Surah surah;

  const SurahIndividual({Key key, @required this.surah}) : super(key: key);

  @override
  _SurahIndividualState createState() => _SurahIndividualState();
}

class _SurahIndividualState extends State<SurahIndividual> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provider<DBProvider>(
      create: (context) => DBProvider(),
      //dispose: (context, value) => value.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Surah"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _controller,
          children: [
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    "${widget.surah.id}. ${widget.surah.latin}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(child: SurahIndividualWithAyahs(surahInfo: widget.surah,)),
          ],
        ),
      ),
    );
  }
}
