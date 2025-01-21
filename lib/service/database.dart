import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //CREATE
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future addNoteDetails(Map<String, dynamic> noteInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("note")
        .doc(id)
        .set(noteInfoMap);
  }

  //READ
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("employee").snapshots();
  }

  Future<Stream<QuerySnapshot>> getNoteDetails() async {
    return await FirebaseFirestore.instance.collection("note").snapshots();
  }

  //UPDATE
  Future updateEmployeeDetail(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("employee")
        .doc(id)
        .update(updateInfo);
  }

  Future updateNoteDetail(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("note")
        .doc(id)
        .update(updateInfo);
  }

  //DELETE
  Future deleteEmployeeDetail(String id) async {
    return await FirebaseFirestore.instance
        .collection("employee")
        .doc(id)
        .delete();
  }

  Future deleteNoteDetail(String id) async {
    return await FirebaseFirestore.instance.collection("note").doc(id).delete();
  }
}