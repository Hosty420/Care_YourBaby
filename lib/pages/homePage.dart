import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

const _kPages = <String, IconData>{
  'Preguntas': Icons.question_answer,
  'Ejercicio': Icons.sports_volleyball,
  'Nutrición': Icons.food_bank_rounded,
  'Tú': Icons.pregnant_woman_sharp,
  'Agenda': Icons.calendar_today_sharp
};

class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({Key key}) : super(key: key);

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<ConvexAppExample> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          leading: IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.question_answer),
            onPressed: () => showModalBottomSheet(
                context: context, builder: (ctx) => _buildBottomSheet(ctx)),
          ),
          automaticallyImplyLeading: false,
          //iconTheme: Icons.question_answer_outlined,
          title: const Text('PREGUNTAS FRECUENTES'),
          backgroundColor: Color.fromRGBO(151, 84, 247, 1),
        ),
        body: SingleChildScrollView(child: _body()),
        bottomNavigationBar: _menu(),
      ),
    );
  }

  Widget _body() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // _preguntas(),
        _expansion(),
      ],
    );
  }

  Widget _menu() {
    return ConvexAppBar(
      style: _tabStyle,
      color: Colors.white,
      backgroundColor: Colors.black,
      items: <TabItem>[
        for (final entry in _kPages.entries)
          TabItem(icon: entry.value, title: entry.key),
      ],
    );
  }

  List<bool> _isExpanded = List.generate(1, (_) => false);

  final String response =
      'Si quieres saber cómo ser una buena madre, a continuación '
      'puedes encontrar una lista de consejos que te ayudarán a evitar '
      'errores de crianza.';
  final String reference =
      "https://psicologiaymente.com/desarrollo/consejos-ser-buena-madre";

  Widget _expansion() {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(239, 236, 243, 1),
        child: Card(
            borderOnForeground: true,
            elevation: 1,
            child: ExpansionPanelList(
              dividerColor: Colors.black,
              elevation: 1,
              expansionCallback: (index, isExpanded) => setState(() {
                _isExpanded[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      subtitle: Text(
                        response,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    headerBuilder: (_, isExpanded) {
                      return Center(
                        child: Text(
                          '¿Cómo ser una buena mamá?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _isExpanded[i],
                  )
              ],
            )),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple.shade400, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        children: <Widget>[
          const ListTile(title: Text('Registra tu pregunta')),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.person),
              labelText: 'Ingresa tu nombre (Opcional)',
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.pregnant_woman_rounded),
              labelText: 'Ingresa tu duda',
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
              onPressed: () {},
              child: Text(
                '   Guardar  ',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
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
