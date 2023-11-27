import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FirestorageManager {
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

  Future<String> writeRecording(String schoolCode, String classId, String studentId, int questionNo, String testStartTime) async {
    try {
      final Reference dirRef1 = FirebaseStorage.instance.ref().child('$schoolCode-$classId-$studentId');
      final Reference dirRef2 = dirRef1.child('$testStartTime');

      Directory? ex1 = await getExternalStorageDirectory();
      String dirPath = '${ex1!.path}/$schoolCode-$classId-$studentId/$testStartTime';

      String filePath = '$dirPath/$questionNo.wav';
      File file = File(filePath);
      print("debug : cloud file path ${filePath}");

      // Ensure the file exists before trying to upload
      if (await file.exists()) {
        // Upload the file to Firebase Storage
        final UploadTask uploadTask = dirRef2.child('$questionNo.wav').putFile(file);

        final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        final String downloadURL = await snapshot.ref.getDownloadURL();

        return downloadURL;
      } else {
        print('File does not exist at path: $filePath');
        return ''; // Handle this case appropriately
      }
    } catch (e) {
      // Handle errors
      print('Error uploading file: $e');
      return ''; // Handle this case appropriately
    }
  }
}