import 'package:flutter/material.dart';

class Training extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageTraining();
}

class ManageTraining extends State<Training> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("TRAINING PAGE"),
          )
        ],
      ),
    );
  }
}
