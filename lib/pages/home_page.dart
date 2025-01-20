import 'package:firebase/pages/login_page.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controllers/employee_controllers.dart';
import 'employee.dart';

class Home extends StatelessWidget {
  final EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    controller.fetchEmployees();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // Disable the back button
        title: Text(
          "Employee Management",
          style: AppStyles.heading1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.fetchEmployees();
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              // Get.offAll(() => LoginPage());
              Get.defaultDialog(
                title: "Log Out",
                middleText: "Are you sure you want to log out?",
                titleStyle: AppStyles.heading1.copyWith(color: AppStyles.backGroundColor),
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
                    padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
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
                    padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.radiusXXL),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "Yes",
                    style: AppStyles.button.copyWith(color: AppStyles.textColor),
                  ),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.employees.isEmpty) {
          return const Center(child: Text("No employees found."));
        }
        return ListView.builder(
          itemCount: controller.employees.length,
          itemBuilder: (context, index) {
            var employee = controller.employees[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: AppStyles.paddingS, horizontal: AppStyles.paddingL),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
              ),
              color: AppStyles.backGroundColor,
              child: ListTile(
                contentPadding: EdgeInsets.all(AppStyles.paddingL),
                title: Text(
                  employee["Name"] ?? "No Name",
                  style: AppStyles.heading1
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age: ${employee["Age"] ?? 'Unknown'}",
                      style: AppStyles.text,
                    ),
                    Text(
                      "Location: ${employee["Location"] ?? 'Unknown'}",
                      style: AppStyles.text,
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(IconlyBold.edit, size: AppStyles.iconL, color: AppStyles.textColor),
                      onPressed: () {
                        Get.dialog(EditEmployeeDialog(employee: employee));
                      },
                    ),
                    IconButton(
                      icon: Icon(IconlyBold.delete, size: AppStyles.iconL, color: AppStyles.error),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Delete",
                          middleText: "Are you sure you want to delete this data?",
                          titleStyle: AppStyles.heading1.copyWith(color: AppStyles.backGroundColor),
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
                              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
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
                              controller.deleteEmployee(employee["Id"]);
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyles.backGroundColor,
                              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppStyles.radiusXXL),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              "Yes",
                              style: AppStyles.button.copyWith(color: AppStyles.textColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Employee());
        },
        backgroundColor: AppStyles.textColor,
        child: Icon(IconlyBold.plus, size: AppStyles.iconXL, color: AppStyles.backGroundColor),
      ),
    );
  }
}

class EditEmployeeDialog extends StatelessWidget {
  final Map<String, dynamic> employee;
  final EmployeeController controller = Get.find();

  EditEmployeeDialog({required this.employee});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: employee["Name"]);
    TextEditingController ageController =
    TextEditingController(text: employee["Age"]);
    TextEditingController locationController =
    TextEditingController(text: employee["Location"]);

    return AlertDialog(
      title: const Text("Edit Employee"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField("Name", nameController),
          _buildTextField("Age", ageController),
          _buildTextField("Location", locationController),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> updatedData = {
              "Name": nameController.text,
              "Age": ageController.text,
              "Location": locationController.text,
              "Id": employee["Id"],
            };
            controller.updateEmployee(employee["Id"], updatedData);
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
