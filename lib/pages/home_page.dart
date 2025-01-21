import 'package:firebase/pages/login_page.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controllers/NoteController.dart';
import 'notes.dart';

class Homie extends StatelessWidget {
  final NoteController controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    controller.fetchNotes();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the back button
        title: Align(
          alignment: Alignment.centerLeft, // Align title to the left
          child: Text(
            "Notes",
            style: AppStyles.heading1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.fetchNotes();
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              controller.fetchNotes();
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              // Get.offAll(() => LoginPage());
              Get.defaultDialog(
                title: "Log Out",
                middleText: "Are you sure you want to log out?",
                titleStyle: AppStyles.heading1
                    .copyWith(color: AppStyles.backGroundColor),
                middleTextStyle: AppStyles.button,
                backgroundColor: AppStyles.textColor,
                radius: AppStyles.radiusXL,
                barrierDismissible: false,
                cancel: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppStyles.backGroundColor),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppStyles.paddingL,
                        vertical: AppStyles.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.radiusXXL),
                    ),
                  ),
                  child: Text(
                    "No",
                    style: AppStyles.button,
                  ),
                ),
                confirm: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => LoginPage());
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.backGroundColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppStyles.paddingL,
                        vertical: AppStyles.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.radiusXXL),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "Yes",
                    style:
                    AppStyles.button.copyWith(color: AppStyles.textColor),
                  ),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.notes.isEmpty) {
          return const Center(child: Text("No notes found."));
        }
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            var note = controller.notes[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the Note page when the card is tapped
                Get.to(() => Note());
              },
              child: Card(
                margin: EdgeInsets.symmetric(
                    vertical: AppStyles.paddingS,
                    horizontal: AppStyles.paddingL),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.radiusM),
                ),
                color: const Color.fromARGB(255, 43, 43, 43),
                child: ListTile(
                  contentPadding: EdgeInsets.all(AppStyles.paddingL),
                  title: Text(note["Title"] ?? "Untitled",
                      style: AppStyles.heading1.copyWith(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${note["Phar"] ?? 'Unknown'}",
                        style: AppStyles.text.copyWith(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(IconlyBold.delete,
                            size: AppStyles.iconL,
                            color: const Color.fromARGB(255, 196, 122, 116)),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Delete",
                            middleText:
                            "Are you sure you want to delete this data?",
                            titleStyle: AppStyles.heading1.copyWith(
                                color: const Color.fromARGB(255, 241, 59, 59)),
                            middleTextStyle: AppStyles.button,
                            backgroundColor: AppStyles.textColor,
                            radius: AppStyles.radiusXL,
                            barrierDismissible: false,
                            cancel: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppStyles.backGroundColor),
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppStyles.paddingL,
                                    vertical: AppStyles.paddingM),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.radiusXXL),
                                ),
                              ),
                              child: Text(
                                "No",
                                style: AppStyles.button,
                              ),
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                controller.deleteNote(note["Id"]);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppStyles.backGroundColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppStyles.paddingL,
                                    vertical: AppStyles.paddingM),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.radiusXXL),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                "Yes",
                                style: AppStyles.button
                                    .copyWith(color: AppStyles.textColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Note());
        },
        backgroundColor: AppStyles.textColor,
        child: Icon(IconlyBold.plus,
            size: AppStyles.iconXL, color: AppStyles.backGroundColor),
      ),
    );
  }
}

class EditNoteDialog extends StatelessWidget {
  final Map<String, dynamic> note;
  final NoteController controller = Get.find();

  EditNoteDialog({required this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
    TextEditingController(text: note["Title"]);
    TextEditingController pharController =
    TextEditingController(text: note["Phar"]);

    return AlertDialog(
      title: const Text("Edit Employee"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField("Title", titleController),
          _buildTextField("Phar", pharController),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> updatedData = {
              "Title": titleController.text,
              "Phar": pharController.text,
              "Id": note["Id"],
            };
            controller.updateNote(note["Id"], updatedData);
            Get.back();
          },
          child: const Text("Update"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}