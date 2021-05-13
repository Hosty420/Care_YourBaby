import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:care_yourbaby/pages/questions.dart';
import 'package:care_yourbaby/pages/schedule.dart';
import 'package:care_yourbaby/pages/training.dart';
import 'package:care_yourbaby/pages/you.dart';
import 'package:care_yourbaby/pages/nutrition.dart';

class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({Key key}) : super(key: key);

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<ConvexAppExample> {
  TabStyle _tabStyle = TabStyle.reactCircle;
  var selectedPage = 0;
  final _pageOption = [Questions(), Training(), Nutrition(), You(), Schedule()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        style: _tabStyle,
        color: Colors.white,
        backgroundColor: Colors.black,
        items: [
          TabItem(icon: Icons.question_answer, title: 'Preguntas'),
          TabItem(icon: Icons.sports_volleyball, title: 'Ejercicio'),
          TabItem(icon: Icons.food_bank_rounded, title: 'Nutrición'),
          TabItem(icon: Icons.pregnant_woman_sharp, title: 'Tú'),
          TabItem(icon: Icons.calendar_today_sharp, title: 'Agenda')
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
