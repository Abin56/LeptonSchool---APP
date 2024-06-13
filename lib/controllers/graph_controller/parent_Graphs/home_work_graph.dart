import 'package:get/get.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';
class ParentHomeWorkGraphController extends GetxController{
  Future <void> fecthHomeWork()async{
    await server
       .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection("HomeWorks")
        .doc()
        .collection("Submit")
        .get();
  }
}