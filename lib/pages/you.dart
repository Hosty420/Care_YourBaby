import 'package:flutter/material.dart';

class You extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageYou();
}

class ManageYou extends State<You> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("YOU PAGE"),
          )
        ],
      ),
    );
  }
}
