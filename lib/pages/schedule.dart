import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageSchedule();
}

class ManageSchedule extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("SCHEDULE PAGE"),
          )
        ],
      ),
    );
  }
}
