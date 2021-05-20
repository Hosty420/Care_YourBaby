import 'package:care_yourbaby/pages/correctExercises.dart';
import 'package:care_yourbaby/pages/incorrectExercises.dart';
import 'package:care_yourbaby/pages/questions.dart';
import 'package:flutter/material.dart';

class Training extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageTraining();
}

class ManageTraining extends State<Training> {
  Questions question = new Questions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          leading: IconButton(
            onPressed: () {},
            tooltip: 'Search',
            icon: Icon(Icons.sports_volleyball_outlined),
          ),
          automaticallyImplyLeading: false,
          //iconTheme: Icons.question_answer_outlined,
          title: const Text('ENTRENAMIENTO'),
          backgroundColor: Color.fromRGBO(151, 84, 247, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              introduction(),
              appropriateExercise(),
              inappropriateExercise(),
            ],
          ),
        ));
  }

  Widget introduction() {
    return Container(
        margin: EdgeInsets.only(left: 13.0, right: 13.0),
        child: Column(children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            'LA IMPORTANCIA DE ENTRENARTE',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(
            'No hay duda de que el ejercicio es beneficioso tanto para usted como para su bebé.'
            ' Le invitamos a que explore lo que un buen entrenamiento puede ayudarle a lograr.',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10.0),
        ]));
  }

  Widget appropriateExercise() {
    return Container(
      child: Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/correctExercise.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ejercicios apropiados',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(alignment: MainAxisAlignment.end, children: <Widget>[
            TextButton(
              onPressed: () {
                //Volver ir a la pantalla especificada
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AppropiateE()));
              },
              child: const Text('VER MÁS'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget inappropriateExercise() {
    return Container(
      child: Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/incorrectExercise.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ejercicios inapropiados',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(alignment: MainAxisAlignment.end, children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InappropiateE()));
              },
              child: const Text('VER MÁS'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.purple.shade400;
    }
    return Color.fromRGBO(151, 84, 247, 1);
  }
}
