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
  String coverName;
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

  Future<String> pickupImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      this.coverImage = File(pickedFile.path);
      var arrStr = coverImage.path.split("/");
      this.coverName = arrStr[arrStr.length - 1];
    }
    return this.coverName;
  }

  Future<String> uploadImage() async {
    final StorageUploadTask uploadTask =
        storageRef.child("CoverImages/$coverName").putFile(coverImage);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    return url;
  }
}
