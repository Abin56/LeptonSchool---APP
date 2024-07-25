// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExamResultModel {
  String docid;
  String obtainedGrade;
  String obtainedMark;
  String passMark;
  String studentName;
  String studentid;
  String subjectName;
  String uploadDate;
  ExamResultModel({
    required this.docid,
    required this.obtainedGrade,
    required this.obtainedMark,
    required this.passMark,
    required this.studentName,
    required this.studentid,
    required this.subjectName,
    required this.uploadDate,
  });

  ExamResultModel copyWith({
    String? docid,
    String? obtainedGrade,
    String? obtainedMark,
    String? passMark,
    String? studentName,
    String? studentid,
    String? subjectName,
    String? uploadDate,
  }) {
    return ExamResultModel(
      docid: docid ?? this.docid,
      obtainedGrade: obtainedGrade ?? this.obtainedGrade,
      obtainedMark: obtainedMark ?? this.obtainedMark,
      passMark: passMark ?? this.passMark,
      studentName: studentName ?? this.studentName,
      studentid: studentid ?? this.studentid,
      subjectName: subjectName ?? this.subjectName,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'obtainedGrade': obtainedGrade,
      'obtainedMark': obtainedMark,
      'passMark': passMark,
      'studentName': studentName,
      'studentid': studentid,
      'subjectName': subjectName,
      'uploadDate': uploadDate,
    };
  }

  factory ExamResultModel.fromMap(Map<String, dynamic> map) {
    return ExamResultModel(
      docid: map['docid'] ??"",
      obtainedGrade: map['obtainedGrade'] ??"",
      obtainedMark: map['obtainedMark'] ??"",
      passMark: map['passMark'] ??"",
      studentName: map['studentName'] ??"",
      studentid: map['studentid'] ??"",
      subjectName: map['subjectName'] ??"",
      uploadDate: map['uploadDate'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamResultModel.fromJson(String source) => ExamResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamResultModel(docid: $docid, obtainedGrade: $obtainedGrade, obtainedMark: $obtainedMark, passMark: $passMark, studentName: $studentName, studentid: $studentid, subjectName: $subjectName, uploadDate: $uploadDate)';
  }

  @override
  bool operator ==(covariant ExamResultModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.obtainedGrade == obtainedGrade &&
      other.obtainedMark == obtainedMark &&
      other.passMark == passMark &&
      other.studentName == studentName &&
      other.studentid == studentid &&
      other.subjectName == subjectName &&
      other.uploadDate == uploadDate;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      obtainedGrade.hashCode ^
      obtainedMark.hashCode ^
      passMark.hashCode ^
      studentName.hashCode ^
      studentid.hashCode ^
      subjectName.hashCode ^
      uploadDate.hashCode;
  }
}
