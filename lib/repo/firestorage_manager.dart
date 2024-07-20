import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FirestorageManager {


  ///firestorage에 로컬 디바이스에 있는 녹음 파일을 업로드하는 함수
  Future<String> writeRecording(String schoolCode, String classId, String studentId, int pageNo, String testStartTime) async {
    try {
      final Reference dirRef1 = FirebaseStorage.instance.ref().child('$schoolCode-$classId-$studentId');
      final Reference dirRef2 = dirRef1.child('$testStartTime');

      Directory? ex1 = await getExternalStorageDirectory();
      String dirPath = '${ex1!.path}/$schoolCode-$classId-$studentId/$testStartTime';

      String filePath = '$dirPath/$pageNo.wav';
      File file = File(filePath);
      print("debug : cloud file path ${filePath}");

      // 로컬 디바이스의 dirPath에 해당하는 경로의 녹음 파일이 있다면 firestorage에 녹음 파일 업로드
      if (await file.exists()) {
        // Upload the file to Firebase Storage
        final UploadTask uploadTask = dirRef2.child('$pageNo.wav').putFile(file);

        final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        final String downloadURL = await snapshot.ref.getDownloadURL();

        print(downloadURL);

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