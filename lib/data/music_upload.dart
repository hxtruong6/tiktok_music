import 'dart:async';
import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MusicUpload {
  final StorageReference storageRef =
      FirebaseStorage.instance.ref().child("Music");
  File song;
  File coverImage;
  final imagePicker = ImagePicker();

  void pickupSong() async {
    // FilePickerResult result =
    //     await FilePicker.platform.pickFiles(type: FileType.audio);
    //
    // if (result != null) {
    //   this.songPath = File(result.files.single.path);
    // } else {
    //   // User canceled the picker
    // }

  }

  Future<String> uploadSong() async {
    final StorageUploadTask uploadTask = storageRef.putFile(song);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    return url;
  }

  void pickupImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile!=null) {
      this.coverImage = File(pickedFile.path);
    }
  }

  Future<String> uploadImage() async {
    String fileName = coverImage.path;
    final StorageUploadTask uploadTask = storageRef.child("CoverImage/$fileName").putFile(coverImage);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    return url;
  }
}
