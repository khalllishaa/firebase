import 'package:firebase/controllers/note_controller.dart';
import 'package:get/get.dart';

class NotesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(() => NoteController());  }


}