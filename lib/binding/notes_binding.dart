import 'package:firebase/controllers/note_controllers.dart';
import 'package:get/get.dart';

class NotesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(() => NoteController());  }


}