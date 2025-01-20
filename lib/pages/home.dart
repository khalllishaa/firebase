import 'package:firebase/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controllers.dart';
import 'employee.dart';

class Home extends StatelessWidget {
  final EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    // Memuat data karyawan saat halaman dimuat
    controller.fetchEmployees();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Management"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchEmployees(); // Wrap fetchEmployees in a closure
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Get.offAll(() => LoginPage()); // Wrap Get.offAll in a closure
            },
          ),
        ],
      ),
      body: Obx(() {
        // Menampilkan daftar karyawan menggunakan Obx untuk memantau perubahan data
        if (controller.employees.isEmpty) {
          return const Center(child: Text("No employees found."));
        }

        return ListView.builder(
          itemCount: controller.employees.length,
          itemBuilder: (context, index) {
            var employee = controller.employees[index];
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 6, // Menambah bayangan pada card
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Sudut membulat pada card
              ),
              color: Colors.white, // Card background menjadi hitam
              child: ListTile(
                contentPadding: const EdgeInsets.all(
                    16.0), // Menambah padding di dalam card
                title: Text(
                  employee["Name"] ?? "No Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Ubah teks menjadi putih
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age: ${employee["Age"] ?? 'Unknown'}",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0,
                            0), // Warna teks putih dengan opasitas lebih rendah
                      ),
                    ),
                    Text(
                        "Location: ${employee["Location"] ?? 'Unknown'}",
                        style: TextStyle(
                          color: Colors
                              .black, // Warna teks putih dengan opasitas lebih rendah
                        ),
                        S),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () {
                        // Navigasi ke dialog edit karyawan
                        Get.dialog(EditEmployeeDialog(employee: employee));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () {
                        // Konfirmasi sebelum menghapus karyawan
                        Get.defaultDialog(
                          title: "Delete Employee",
                          middleText:
                              "Are you sure you want to delete this employee?",
                          textConfirm: "Yes",
                          textCancel: "No",
                          onConfirm: () {
                            controller.deleteEmployee(employee["Id"]);
                            Get.back(); // Menutup dialog
                          },
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
          // Navigasi ke halaman form tambah karyawan
          Get.to(() => Employee());
        },
        backgroundColor: const Color.fromARGB(
            255, 255, 255, 255), // Change the background color to black
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Dialog untuk mengedit karyawan
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
            // Mengupdate data karyawan
            Map<String, dynamic> updatedData = {
              "Name": nameController.text,
              "Age": ageController.text,
              "Location": locationController.text,
              "Id": employee["Id"],
            };
            controller.updateEmployee(employee["Id"], updatedData);
            Get.back(); // Menutup dialog
          },
          child: const Text("Update"),
        ),
        ElevatedButton(
          onPressed: () {
            // Menutup dialog tanpa perubahan
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
