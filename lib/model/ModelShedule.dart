import 'package:cloud_firestore/cloud_firestore.dart';

class ModelShedule {
  final String fechaCita;
  final String tipoCita;
  final String recordatorioCita;
  final DocumentReference reference;

  ModelShedule.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['fechaCita'] != null),
        assert(map['tipoCita'] != null),
        assert(map['recordatorioCita'] != null),
        fechaCita = map['fechaCita'],
        tipoCita = map['tipoCita'],
        recordatorioCita = map['recordatorioCita'];

  ModelShedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
