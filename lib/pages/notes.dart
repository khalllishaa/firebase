import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import '../controllers/NoteController.dart';
import '../widgets/AppStyles.dart';

class Note extends StatelessWidget {
  final NoteController controller = Get.put(NoteController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pharController = TextEditingController();

  final Map<String, dynamic>? note;

  Note({this.note}) {
    // Prefill the text fields if a note is passed
    if (note != null) {
      titleController.text = note!["Title"] ?? "";
      pharController.text = note!["Phar"] ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // If the note exists, update it; otherwise, create a new one
              if (note != null) {
                // Update existing note
                Map<String, dynamic> updatedData = {
                  "Title": titleController.text,
                  "Phar": pharController.text,
                  "Id": note!["Id"],
                };
                controller.updateNote(note!["Id"], updatedData);
              } else {
                // Add new note
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> data = {
                  "Title": titleController.text,
                  "Phar": pharController.text,
                  "Id": id,
                };
                controller.addNote(data);
              }
              Get.back();
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            tooltip: 'Save',
          ),
        ],
      ),
      backgroundColor: AppStyles.dark,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _buildTextField("Title", titleController),
              const SizedBox(height: 20),
              _buildNoteContentField("Content", pharController),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 43, 43, 43),
        ),
        style: TextStyle(
          fontSize: 16,
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNoteContentField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 43, 43, 43),
        ),
        style: TextStyle(
          fontSize: 16,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
