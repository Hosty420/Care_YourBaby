import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:care_yourbaby/Util/Utilities.dart';
import 'package:care_yourbaby/model/ModelShedule.dart';

class Schedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageSchedule();
}

class ManageSchedule extends State<Schedule> {
  Utilities util = new Utilities();
  var _fecha = "";
  var _firstValue = 'Seleccionar tipo de cita';
  var _secondValue = 'Seleccionar recordatorio';
  final _keyForm = GlobalKey<FormState>();

  List<String> typesSchedule = <String>[
    'Seleccionar tipo de cita',
    'Control',
    'Medicina general',
    'Nutricionista',
    'Médico especialista',
    'Ecografia'
  ];

  List<String> reminders = <String>[
    'Seleccionar recordatorio',
    '8 horas antes',
    '2 dias antes',
    '4 dias antes',
    '1 Semana antes'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[],
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_today_sharp),
            ),
            automaticallyImplyLeading: false,
            //iconTheme: Icons.question_answer_outlined,
            title: const Text('AGENDA'),
            backgroundColor: Color.fromRGBO(151, 84, 247, 1),
          ),
          body: SingleChildScrollView(child: _body())),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        _formShedule(),
        _dataTableShedule(),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }

  _formShedule() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Form(
          key: _keyForm,
          child: Column(children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Agenda tu cita",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(151, 84, 247, 1),
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
                controller: TextEditingController(text: _fecha.toString()),
                validator: (value) {
                  if (value.isEmpty || null == value) {
                    return 'La fecha no puede estar vacia.';
                  }
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.calendar_today),
                  hintText: '¿Fecha de cita?',
                  labelText: 'Fecha *',
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (String valor) async {
                  _fecha = valor;
                  print("el valor del campo [Fecha] es: $_fecha ...");
                }),
            SizedBox(
              height: 20.0,
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              icon: Icon(Icons.arrow_downward),
              value: _firstValue,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Color.fromRGBO(151, 84, 247, 1)),
              items:
                  typesSchedule.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _firstValue = value;
                });
              },
              validator: (value) {
                if (value.isEmpty || value == "Seleccionar tipo de cita") {
                  return 'Debe seleccionar un tipo de cita.';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              icon: Icon(Icons.arrow_downward),
              value: _secondValue,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Color.fromRGBO(151, 84, 247, 1)),
              items: reminders.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _secondValue = value;
                });
              },
              validator: (value) {
                if (value.isEmpty || value == "Seleccionar recordatorio") {
                  return 'Debe seleccionar un recordatorio.';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: 150.0,
              height: 40.0,
              onPressed: () {
                if (_keyForm.currentState.validate()) {
                  util.showWindowDialog(
                    context,
                    titulo: "Datos Ingresados",
                    mensaje:
                        "Fecha: $_fecha \nTipo de cita: $_firstValue \nRecordatorio: $_secondValue",
                    boton: "Ok",
                  );
                  _addSchedule();
                  _cleanSchedule();
                }
              },
              color: Color.fromRGBO(151, 84, 247, 1),
              child: Text('Registrar', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Citas agendadas",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(151, 84, 247, 1),
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal),
            ),
            SizedBox(
              height: 20.0,
            ),
          ])),
    );
  }

  Future<void> _addSchedule() {
    CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Schedule');
    return coleccion
        .add({
          'fechaCita': this._fecha,
          'tipoCita': this._firstValue,
          'recordatorioCita': this._secondValue
        })
        .then((value) => util.showToast(context,
            mensaje: 'Datos adicionados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.showToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }

  Widget _dataTableShedule() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Schedule').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return DataTable(columns: [
          DataColumn(
              label: Text('Fecha Cita',
                  style: TextStyle(fontStyle: FontStyle.normal))),
          DataColumn(
              label: Text('Tipo Cita',
                  style: TextStyle(fontStyle: FontStyle.normal))),
          DataColumn(
              label: Text('Recordatorio Cita',
                  style: TextStyle(fontStyle: FontStyle.normal)))
        ], rows: _buildList(context, snapshot.data.docs));
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final records = ModelShedule.fromSnapshot(data);

    return DataRow(cells: [
      DataCell(Text(records.fechaCita)),
      DataCell(Text(records.tipoCita)),
      DataCell(Text(records.recordatorioCita))
    ]);
  }

  void _cleanSchedule() {
    this._fecha = '';
    this._firstValue = 'Seleccionar tipo de cita';
    this._secondValue = 'Seleccionar recordatorio';
  }
}
