import 'package:get/get.dart';
import 'package:firebase/service/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class NoteController extends GetxController {
  var name = ''.obs;
  var age = ''.obs;
  var location = ''.obs;

  var notes = [].obs;

  var title = ''.obs;
  var phar = ''.obs;

  void fetchNotes() async {
    var stream = await DatabaseMethods().getNoteDetails();
    stream.listen((snapshot) {
      notes.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void addNote(Map<String, dynamic> data) async {
    String id = data["Id"];
    await DatabaseMethods().addNoteDetails(data, id).then((value) {
      Fluttertoast.showToast(
        msg: "Note added successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      fetchNotes();
    });
  }

  void deleteNote(String id) async {
    await DatabaseMethods().deleteNoteDetail(id).then((value) {
      Fluttertoast.showToast(
        msg: "Note deleted successfully",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      fetchNotes();
    });
  }

  void updateNote(String id, Map<String, dynamic> data) async {
    await DatabaseMethods().updateNoteDetail(id, data).then((value) {
      Fluttertoast.showToast(
        msg: "Employee updated successfully",
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
      fetchNotes();
    });
  }
}
