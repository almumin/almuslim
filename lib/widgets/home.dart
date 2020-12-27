import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Al-Muslim"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Text("Sunday, 27 December 2020"),
                Text("Sunday, 27 December 2020"),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.icecream,
                    size: 100,
                    color: Colors.black,
                  ),
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 100,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
