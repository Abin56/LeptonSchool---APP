import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';

class HomeWorkListController extends GetxController {
  RxBool status = false.obs;
  RxBool homeworkStatus = false.obs;

  updateCompleteStatus(
      {required String homeworkID, required String docID}) async {
    try {
      String? formattedDate = status.value ? DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()) : null;
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection("classes")
          .doc(UserCredentialsController.classId)
          .collection("HomeWorks")
          .doc(homeworkID)
          .collection('Submit')
          .doc(docID)
          .update({
        'Status': status.value,
        'submittedDate': formattedDate,
        'downloadUrl': '',
      }).then(
        (value) => log('update completed'),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  setUpdateCompleteStatus(
      {required String studentid,
      required String homeWorkName,
      required String homeworkID,
      required String studentName}) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection("classes")
          .doc(UserCredentialsController.classId)
          .collection("HomeWorks")
          .doc(homeworkID)
          .collection('Submit')
          .doc(studentid)
          .set({
        'Status': true,
        'homeWorkName': homeWorkName,
        'homeworkID': homeworkID,
        'submittedDate': formattedDate,
        'downloadUrl': '',
        'docid': studentid,
        'uploadedBy': studentName
      }).then(
        (value) => log('creation completed'),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  fetchHomeWork({required String homeworkID}) async {
    try {
      server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('HomeWorks')
          .doc(homeworkID)
          .collection('Submit')
          .doc(UserCredentialsController.studentModel!.docid)
          .get()
          .then((value) => homeworkStatus.value = value['Status']);
    } catch (e) {
      log(e.toString());
    }
  }
}
