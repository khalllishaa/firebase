import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  //CREATE
  Future addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id)async{
  return await FirebaseFirestore.instance
      .collection("employee")
      .doc(id)
      .set(employeeInfoMap);
  }

  //READ
  Future<Stream<QuerySnapshot>> getEmployeeDetails()async{
    return await FirebaseFirestore.instance.collection("employee").snapshots();
  }


  //UPDATE
  Future updateEmployeeDetail(String id, Map <String, dynamic> updateInfo)async{
    return await FirebaseFirestore.instance.collection("employee").doc(id).update(updateInfo);
  }

  //DELETE
  Future deleteEmployeeDetail(String id) async {
    return await FirebaseFirestore.instance.collection("employee").doc(id).delete();
  }

}
