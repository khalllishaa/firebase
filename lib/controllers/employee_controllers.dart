import 'package:get/get.dart';
import 'package:firebase/service/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class EmployeeController extends GetxController {
  var name = ''.obs;
  var age = ''.obs;
  var location = ''.obs;
  var employees = [].obs;

  void fetchEmployees() async {
    var stream = await DatabaseMethods().getEmployeeDetails();
    stream.listen((snapshot) {
      employees.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void addEmployee(Map<String, dynamic> data) async {
    String id = data["Id"];
    await DatabaseMethods().addEmployeeDetails(data, id).then((value) {
      Fluttertoast.showToast(
        msg: "Employee added successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      fetchEmployees();
    });
  }

  void deleteEmployee(String id) async {
    await DatabaseMethods().deleteEmployeeDetail(id).then((value) {
      Fluttertoast.showToast(
        msg: "Employee deleted successfully",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      fetchEmployees();
    });
  }

  void updateEmployee(String id, Map<String, dynamic> data) async {
    await DatabaseMethods().updateEmployeeDetail(id, data).then((value) {
      Fluttertoast.showToast(
        msg: "Employee updated successfully",
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
      fetchEmployees();
    });
  }
}
