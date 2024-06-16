import 'package:get/get.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';

class StudentExamResultGraphController extends GetxController{
  Future<void> fectchExamResult ()async{
    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
       .collection('Students')
       .doc(UserCredentialsController.studentModel?.docid)
       .collection('Exam Results')
       .doc()
       .collection('Marks')
        .get();
  }
}