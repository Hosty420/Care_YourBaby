import 'package:url_launcher/url_launcher.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:care_yourbaby/Util/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  var _nombre = "";
  var _pregunta = "";
  final _keyForm = GlobalKey<FormState>();
  Utilities util = new Utilities();

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
        _pregunta1(),
        _pregunta2(),
        _pregunta3(),
        _pregunta4(),
        _pregunta5(),
        SizedBox(
          height: 20.0,
        )
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

  List<bool> _isExpanded1 = List.generate(1, (_) => false);
  List<bool> _isExpanded2 = List.generate(1, (_) => false);
  List<bool> _isExpanded3 = List.generate(1, (_) => false);
  List<bool> _isExpanded4 = List.generate(1, (_) => false);
  List<bool> _isExpanded5 = List.generate(1, (_) => false);

  final String response1 =
      'Ayudar a los hijos a seguir sus sueños y proporcionarle el estímulo suficiente es importante.'
      ' Esto comienza con la comprensión de que tu hijo puede pensar diferente a ti y le permites tomar'
      ' sus propias decisiones aún a sabiendas que puede equivocarse… Mientras estás a su lado para apoyarle'
      ' en cuanto te necesites. Ya tomas muchas decisiones por tu hijo, como lo que come cada día o a la '
      'escuela que va… Pero es saludable que puedan expresarse con sus decisiones y por ejemplo, que decidan'
      ' qué música escuchar o qué quieren ser de mayores.';
  final String response2 =
      'Ahora que usted está comiendo para dos (¡o más!), no es el mejor momento para escatimar calorías '
      'o ponerse a dieta. De hecho, ocurre justamente lo contrario –necesita aproximadamente 300 calorías'
      ' diarias más, sobre todo cuando el embarazo esté bastante avanzado y el bebé crezca más deprisa. '
      'Si usted está muy delgada, es muy activa o espera varios bebés, necesitará ingerir todavía más '
      'calorías. Pero, si tiene sobrepeso, es posible que su médico le recomiende no aumentar tanto la'
      ' ingesta de calorías.';
  final String response3 =
      'No siempre es posible evitar la preeclampsia, pero si tenés uno de los factores de riesgo conocidos,'
      ' podés tomar algunas precauciones.'
      'Identificá y comunicá cualquier factor de riesgo, preferiblemente antes de quedar embarazada. '
      'Por ejemplo, controlá la presión arterial alta; perdé peso si es necesario y si tenés diabetes,'
      ' asegurate de que la enfermedad esté bien controlada antes de quedar embarazada. Tus médicos'
      ' pueden aconsejarte sobre los mejores pasos a seguir si ya has quedado embarazada y tenés uno '
      'de estos factores de riesgo.';
  final String response4 =
      'Algunos estudios de laboratorio resultaron favorables al uso de tinte ya que no encontraron daño'
      ' alguno en roedores a los que se aplicó grandes dosis de un tinte. Otras investigaciones encontraron'
      ' daños cromosómicos en mujeres, no embarazadas, que se tiñen el pelo, lo que despertó la posibilidad'
      ' de que esta alteración podría representar un riesgo al bebé de una mujer embarazada.'
      'No existen razones para acreditar que los tintes que se usan hoy en día, produzcan defectos de '
      'nacimiento o pérdidas del embarazo, ni tampoco para eliminar todo tipo de riesgo.';
  final String response5 =
      '¿Pueden realizarse cada trimestre de embarazo, cada mes, cada 15 días, dos veces a la semana…? '
      'El protocolo de embarazo de la Sociedad Española de Ginecología y Obstetricia (SEGO) establece '
      'tres ecografías con imagen 2D de rutina (una por cada trimestre de embarazo) buscando la eficiencia.'
      ' En el 80 por ciento de los casos son suficientes y no hace falta realizarse más. Se harán más de'
      ' las indicadas en los casos de embarazo de riesgo como ocurre por ejemplo en la gestación gemelar,'
      ' la hipertensión, los crecimientos intrauterinos restringidos, las hemorragias, tras haber aplicado'
      ' técnicas de reproducción asistida para quedarse embarazada, o si se ha detectado alguna anomalía en '
      'la prueba de cribado del primer trimestre para descubrir cromosomopatías como el síndrome de Down, etc.'
      ' Ahora bien usted puede realizarse las que desee con un ginecólogo privado, no hay límite siempre y '
      'cuando las abone. Pero debe saber que en la Seguridad Social y en las entidades privadas solo le '
      'realizarán tres si todo va bien.';

  final String reference =
      "https://psicologiaymente.com/desarrollo/consejos-ser-buena-madre";

  Widget _pregunta1() {
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
                _isExpanded1[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      title: Text(
                        response1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                      subtitle: InkWell(
                          onTap: () => launch(
                              'https://www.etapainfantil.com/ser-buena-madre'),
                          child: Text(
                            'https://www.etapainfantil.com/ser-buena-madre',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          )),
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
                    isExpanded: _isExpanded1[i],
                  )
              ],
            )),
      ),
    );
  }

  Widget _pregunta2() {
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
                _isExpanded2[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      title: Text(
                        response2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                      subtitle: InkWell(
                          onTap: () => launch(
                              'https://kidshealth.org/es/parents/preg-health-esp.html'),
                          child: Text(
                            'https://kidshealth.org/es/parents/preg-health-esp.html',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    headerBuilder: (_, isExpanded) {
                      return Center(
                        child: Text(
                          '¿Cómo cuidarme en el embarazo?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _isExpanded2[i],
                  )
              ],
            )),
      ),
    );
  }

  Widget _pregunta3() {
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
                _isExpanded3[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      title: Text(
                        response3,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                      subtitle: InkWell(
                          onTap: () => launch(
                              'https://www.pampers.com.ar/embarazo/embarazo-saludable/art%C3%ADculo/que-es-preeclampsia-y-como-prevenirla'),
                          child: Text(
                            'https://www.pampers.com.ar/embarazo/embarazo-saludable/art%C3%ADculo/que-es-preeclampsia-y-como-prevenirla',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    headerBuilder: (_, isExpanded) {
                      return Center(
                        child: Text(
                          '¿Cómo evitar la preeclampsia?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _isExpanded3[i],
                  )
              ],
            )),
      ),
    );
  }

  Widget _pregunta4() {
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
                _isExpanded4[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      title: Text(
                        response4,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                      subtitle: InkWell(
                          onTap: () => launch(
                              'https://www.guiainfantil.com/blog/132/estoy-embarazada-puedo-tenir-mi-pelo.html#:~:text=Aunque%20muchos%20m%C3%A9dicos%20recomiendan%20cautela,tintes%20puedan%20da%C3%B1ar%20al%20feto.'),
                          child: Text(
                            'https://www.guiainfantil.com/blog/132/estoy-embarazada-puedo-tenir-mi-pelo.html',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    headerBuilder: (_, isExpanded) {
                      return Center(
                        child: Text(
                          '¿Me puedo tinturar mientras estoy en embarazo?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _isExpanded4[i],
                  )
              ],
            )),
      ),
    );
  }

  Widget _pregunta5() {
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
                _isExpanded5[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < 1; i++)
                  ExpansionPanel(
                    backgroundColor: Color.fromRGBO(239, 236, 243, 1),
                    body: ListTile(
                      title: Text(
                        response5,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      ),
                      subtitle: InkWell(
                          onTap: () => launch(
                              'https://www.natalben.com/embarazo-pruebas-y-ecografias/ecografias-son-seguras-cuantas-puedo-hacerme#:~:text=%C2%BFPueden%20realizarse%20cada%20trimestre%20de,de%20embarazo)%20buscando%20la%20eficiencia.'),
                          child: Text(
                            'https://www.natalben.com/embarazo-pruebas-y-ecografias/ecografias-son-seguras',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    headerBuilder: (_, isExpanded) {
                      return Center(
                        child: Text(
                          '¿Cada cuánto me debo hacer la ecografía?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _isExpanded5[i],
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
        child: Form(
          key: _keyForm,
          child: ListView(
            children: <Widget>[
              const ListTile(title: Text('Registra tu pregunta')),
              TextField(
                  controller: TextEditingController(text: _nombre.toString()),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                    labelText: 'Ingresa tu nombre (Opcional)',
                  ),
                  onChanged: (String valor) async {
                    _nombre = valor;
                  }),
              SizedBox(height: 10.0),
              TextFormField(
                  controller: TextEditingController(text: _pregunta.toString()),
                  validator: (value) {
                    if (value.isEmpty || null == value) {
                      return 'El campo no debe estar vacio.';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.pregnant_woman_rounded),
                    labelText: 'Ingresa tu duda',
                  ),
                  onChanged: (String valor) async {
                    _pregunta = valor;
                  }),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor),
                  ),
                  onPressed: () {
                    if (_keyForm.currentState.validate()) {
                      util.showWindowDialog(context,
                          titulo: "Datos Ingresados",
                          mensaje: "Nombre : $_nombre \nPregunta: $_pregunta",
                          boton: "Ok");
                      _addQuestion();
                    }
                  },
                  child: Text(
                    '   Guardar  ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _addQuestion() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Question');
    return collection
        .add({'nombre': this._nombre, 'pregunta': this._pregunta})
        .then((value) => util.showToast(context,
            mensaje: 'Datos adicionados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.showToast(context, mensaje: 'Error: $error', boton: 'Ok'));
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
