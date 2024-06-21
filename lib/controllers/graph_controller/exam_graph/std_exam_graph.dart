import 'package:get/get.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/model/exam_list_model/examresult_model.dart';
import 'package:lepton_school/utils/utils.dart';

class StudentExamResultGraphController extends GetxController {
  final totalExamsCount = 0.obs;
  final passedExamsCount = 0.obs;
  Future<int> fetchExamResult(String exam) async {
    int studentExamPassTotalCount = 0;
    int studentExamTotalCount = 0;

    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('Students')
        .doc(UserCredentialsController.studentModel?.docid)
        .collection('Exam Results')
        .doc(exam)
        .collection('Marks')
        .get()
        .then((examvalue) {
      studentExamTotalCount = examvalue.docs.length;
      for (var i = 0; i < examvalue.docs.length; i++) {
        int obtainedMark =
            int.parse(examvalue.docs[i].data()['obtainedMark'].toString());
        int passMark =
            int.parse(examvalue.docs[i].data()['passMark'].toString());
        if (obtainedMark >= passMark) {
          studentExamPassTotalCount++;
        }
      }

  //    log("passcount${studentExamPassTotalCount.toString()}");
    });
    totalExamsCount.value = studentExamTotalCount;
    passedExamsCount.value = studentExamPassTotalCount;
  //  log("totalexam${studentExamTotalCount.toString()}");

    return studentExamPassTotalCount;
  }

  Future<List<ExamResultModel>> getStudentExamStatus() async {
   // log(".....................");
    List<ExamResultModel> getStudentExamStatus = [];
    var examList = await fetchExams();
    for (var i = 0; i < examList.length; i++) {
      await server
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('Students')
          .doc(UserCredentialsController.studentModel?.docid)
          .collection('Exam Results')
          .doc(examList[i])
          .collection('Marks')
          .get()
          .then((value) async {
        final fetchData = value.docs.map((e) {
          return ExamResultModel.fromMap(e.data());
        }).toList();
        getStudentExamStatus.addAll(fetchData);
      });
    }
  //  log(getStudentExamStatus.toString());
    return getStudentExamStatus;
  }

  Future<Map<String, int>> examgraphData() async {
    var studentData = await getStudentExamStatus(); 
    int studentExamPassTotalCount = 0;
      int studentExamFailedTotalCount = 0;

    int totalExamCount = studentData.length;
    for (var i = 0; i < studentData.length; i++) {
      if (int.parse(studentData[i].obtainedMark) >=
          int.parse(studentData[i].passMark)) {
        studentExamPassTotalCount = studentExamPassTotalCount + 1;
      }else{
        studentExamFailedTotalCount = studentExamFailedTotalCount+1;
      }
    }

    return {
      'studentExamPassTotalCount': studentExamPassTotalCount,
      'totalExamCount': totalExamCount,
      'studentExamFailedTotalCount':studentExamFailedTotalCount
    };
  }

  Future<List<String>> fetchExams() async {
    List<String> examNames = [];

    await server
        .collection(UserCredentialsController.batchId ?? "")
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('Students')
        .doc(UserCredentialsController.studentModel?.docid)
        .collection('Exam Results')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        examNames.add(doc.id);
      }
    });

    return examNames;
  }
}
