import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lepton_school/controllers/graph_controller/students_Graph/attendence_grphStatus.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/utils/utils.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:lepton_school/view/home/student_home/graph_std/std_attendance_details.dart';
import 'package:lepton_school/view/widgets/fonts/google_lemon.dart';
import 'package:lepton_school/view/widgets/fonts/google_salsa.dart';

attendanceOnClickDetailsShowing() {
    final studentAttendanceGrpghStatus = Get.put(StudentAttendenceGrpghStatus());
  
  Get.bottomSheet(
     FutureBuilder<int>(
      future: studentAttendanceGrpghStatus.fetchStudentAttendence(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final presentDays = snapshot.data!;
         

             return FutureBuilder<int>(
            future: studentAttendanceGrpghStatus.totalWorkingDays(),
            builder: (context, totalDaysSnapshot) {
              if (totalDaysSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (totalDaysSnapshot.hasError) {
                return Center(child: Text('Error: ${totalDaysSnapshot.error}'));
              } else if (totalDaysSnapshot.hasData) {
                final totalDays = totalDaysSnapshot.data!;
                final absentDays = totalDays - presentDays;
   return SingleChildScrollView(
    child: Container(
        color: cWhite,
        width: double.infinity,
        height: 700.h,
        child: Wrap(
          children: <Widget>[
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.sp),
                      child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10.sp),
                            child: SizedBox(
                              height: 40.h,
                              child: Image.asset(
                                  'assets/flaticons/icons8-attendance-100.png'),
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child:  Text("Attendance Graph",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp),),
                          ),
                          
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 60.sp, bottom: 70.sp,left: 50.sp),
                        child: SizedBox(
                          height: 120.h,
                          child:  PieChartSample2( totalDays: totalDays,absentDays: absentDays,
                              presentDays: presentDays,),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 25.sp),
                        child: SizedBox(
                          height: 120.h,
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child:  Row(
                                  children: [
                                    const Indicator(
                                        color: Colors.purple,
                                         text: 'Total       ',
                                         isSquare: true,
                                       ),
                                       Text(totalDays.toString(),style: const TextStyle(fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                //  GraphDetailsWidgetOfStd(
                                //     image: "assets/flaticons/menu.png",
                                //     text: 'Total Days ',
                                //     number: '50'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child:  Row(
                                  children: [
                                    const Indicator(
                                      color: Colors.blue,
                                      text: 'Present  ',
                                      isSquare: true,
                                    ),
                                    Text(presentDays.toString(),style: const TextStyle(fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    const Indicator(
                                            color: Colors.green,
                                            text: 'Absent   ',
                                            isSquare: true,
                                          ),
                                          Text(absentDays.toString(),style: const TextStyle(fontWeight: FontWeight.w500))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ],),
                  ],
                ),
                //  Padding(
                //   padding: EdgeInsets.only(top: 10.sp),
                //   child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                //     children: [ GraphDetailsWidgetOfStd(text: 'Absent Days', number: '5', image: "assets/flaticons/menu.png"),],),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                  child: GoogleSalsaWidgets(
                    text: "Absent Days",
                    fontsize: 27.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  color: adminePrimayColor.withOpacity(0.2),
                  //const Color.fromARGB(255, 88, 167, 123).withOpacity(0.3),
                  width: double.infinity,
                  height: 600.h,
                  child: StreamBuilder(
                    stream: server
                      .collection(UserCredentialsController.batchId ?? "")
                      .doc(UserCredentialsController.batchId)
                      .collection('classes')
                      .doc(UserCredentialsController.classId)
                      .collection('Students')
                      .doc(UserCredentialsController.studentModel?.docid)
                      .collection('MyAttendenceList')
                      .snapshots(),
                    builder: (context, dayssnaps) {
                     
                      return ListView.separated(
                        itemBuilder: (context, index) {
                           final data = dayssnaps.data?.docs[index];
                                      final dateString = data?['date']??''.toString();
                                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateString);
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                                     // log(dateString);
                          return Padding(
                            padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                            child: Container(
                              height: 45.h,
                              decoration: const BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 1)],
                                  color: cWhite),
                              child: Row(
                                children: [
                                  Container(
                                    color: cblue,
                                    height: 45.h,
                                    width: 45.w,
                                    child: Center(
                                        child: GoogleLemonWidgets(
                                      text:  '${index+1}',
                                      fontsize: 17.sp,
                                      color: cWhite,
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.sp),
                                    child: Center(
                                        child: GoogleSalsaWidgets(
                                            text: formattedDate,
                                            fontsize: 19.sp)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: dayssnaps.data?.docs.length??0,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1.h,
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ],
        )
        ),
  );
   } else {
                return const Center(child: Text('No data available'));
              }
            },
          );
          } else {
          return const Center(child: Text('No data available'));
        }
      }
     )
  );
}
