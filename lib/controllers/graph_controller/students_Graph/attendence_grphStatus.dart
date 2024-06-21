import 'package:get/get.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';

class StudentAttendenceGrpghStatus extends GetxController {

  Future<int> fetchStudentAttendence() async {
  int studentAttendanceTotalCount = 0;
    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('Students')
        .doc(UserCredentialsController.studentModel?.docid)
        .collection('MyAttendenceList')
        .get()
        .then((studentAttendanceValue) async {
          for (var i = 0; i < studentAttendanceValue.docs.length; i++) {
            if (studentAttendanceValue.docs[i].data()['present']==true) {
             studentAttendanceTotalCount= studentAttendanceTotalCount+1 ;
            }
          }
       
        //  log(studentAttendanceTotalCount.toString());
        });
        return studentAttendanceTotalCount;
  }

  Future<int> totalWorkingDays()async{
     int totalDaysCount = 0;
    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .get()
        .then((value) {
          totalDaysCount=value.data()?['workingDaysCount'];
        });
         return totalDaysCount;
  }
   Future<int> fetchStudentAttendenceToParent() async {
  int studentTotalAttendanceCount = 0;
    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('Students')
        .doc(UserCredentialsController.parentModel?.studentID)
        .collection('MyAttendenceList')
        .get()
        .then((attendanceValue) async {
          for (var i = 0; i < attendanceValue.docs.length; i++) {
            if (attendanceValue.docs[i].data()['present']==true) {
             studentTotalAttendanceCount= studentTotalAttendanceCount+1 ;
            }
          }
       
        //  log(studentTotalAttendanceCount.toString());
        });
        return studentTotalAttendanceCount;
  }
}
