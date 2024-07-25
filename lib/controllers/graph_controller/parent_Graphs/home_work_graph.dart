import 'dart:developer';

import 'package:get/get.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';

class StudentHomeWorkGraphController extends GetxController {
   final completedHomeWorkCount = 0.obs;
  final totalHomeWorkCount = 0.obs;
  Future<void> fecthHomeWorkCompletedCount() async {
    int studentHomeWorkCompletedCount = 0;

    final homeworkId = await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId!)
        .collection("HomeWorks")
        .get();

    if (homeworkId.docs.isNotEmpty) {
      for (var homeworkDoc in homeworkId.docs) {
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(UserCredentialsController.classId!)
            .collection("HomeWorks")
            .doc(homeworkDoc.id)
            .collection("Submit")
            .get()
            .then((homeworkValue) async {
          for (var i = 0; i < homeworkValue.docs.length; i++) {
            if (homeworkValue.docs[i].data()['Status'] == true) {
              studentHomeWorkCompletedCount = studentHomeWorkCompletedCount + 1;
            }
          }

           log("Haiiiiiii${studentHomeWorkCompletedCount.toString()}");
        });
      }
    }
    completedHomeWorkCount.value = studentHomeWorkCompletedCount;
  }

  Future<void> fetchingTotalHomeworkCount()async{
      int studentHomeWorkTotalCount = 0;
    await server
           .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId!)
        .collection("HomeWorks")
       .get()
        .then((studenthomework) async {
         
       studentHomeWorkTotalCount = studenthomework.docs.length;
        log("Helooooooooo${ studenthomework.docs.length.toString()}");
        });
         totalHomeWorkCount.value = studentHomeWorkTotalCount;
}
  void fetchHomeWorkData() {
    fecthHomeWorkCompletedCount();
    fetchingTotalHomeworkCount();
  }
}