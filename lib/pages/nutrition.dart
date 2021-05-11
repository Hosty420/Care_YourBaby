import 'package:flutter/material.dart';

class Nutrition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageNutrition();
}

class ManageNutrition extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("NUTRITION PAGE"),
          )
        ],
      ),
    );
  }
}
