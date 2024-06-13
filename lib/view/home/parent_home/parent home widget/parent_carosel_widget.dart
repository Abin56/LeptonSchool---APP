import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lepton_school/controllers/graph_controller/students_Graph/attendence_grphStatus.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:lepton_school/view/home/parent_home/graph_std/attendance_std_prnt.dart';
import 'package:lepton_school/view/home/parent_home/graph_std/exm_std.dart';
import 'package:lepton_school/view/home/parent_home/graph_std/homework_std_g.dart';
import 'package:lepton_school/view/home/parent_home/graph_std/pie%20chart/pie_chart.dart';
import 'package:lepton_school/view/home/parent_home/graph_std/project_assignmnt_chart.dart';
import 'package:lepton_school/view/widgets/fonts/google_poppins.dart';

class ParentCaroselWidget extends StatelessWidget {
  const ParentCaroselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
      child: Container(
        height: 248,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: cblack,
          ),
        ], color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 10),
                    child: CarouselSliderWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];
List<String> image = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/icons8-chat-100.png'
];

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final studentAttendenceGrpghStatus =
        Get.put(StudentAttendenceGrpghStatus());
    studentAttendenceGrpghStatus.fetchStudentAttendenceToParent();
    // ignore: avoid_unnecessary_containers
    return CarouselSlider(
      items: [
        CaroselmageWidget(
          sliderWidget: graphList[0],
          slidertext: 'Homework',
          slidersecondtext: 'Average',
          count: '100/200',
          clicktext: '',
        ),
        CaroselmageWidget(
          sliderWidget: graphList[1],
          slidertext: 'Exam Result',
          slidersecondtext: 'Average',
          count: '100/200',
          clicktext: '',
        ),
        GestureDetector(
          onTap: () {
            _settingModalBottomSheet(context);
          },
          child: FutureBuilder<int>(
              future:
                  studentAttendenceGrpghStatus.fetchStudentAttendenceToParent(),
              builder: (context, snapshotPresent) {
                if (snapshotPresent.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshotPresent.hasError) {
                  return const Center(child: Text('Error: '));
                }

                final presentDays = snapshotPresent.data ?? 0;
                return FutureBuilder<int>(
                    future: studentAttendenceGrpghStatus.totalWorkingDays(),
                    builder: (context, snapshotTotalDays) {
                      if (snapshotTotalDays.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshotTotalDays.hasError) {
                        return const Center(child: Text('Error:'));
                      }

                      final totalDays = snapshotTotalDays.data ?? 0;
                      log('Present Days: $presentDays');
                      log('Total Days: $totalDays');
                      return CaroselmageWidget(
                        sliderWidget: graphList[2],
                        slidertext: 'Attendance',
                        slidersecondtext: 'Average',
                        count: "$presentDays" '/' "$totalDays",
                        clicktext: 'Click here',
                      );
                    });
              }),
        ),
        // CaroselmageWidget(
        //   sliderWidget: graphList[3],
        //   slidertext: 'Assignment & Project',
        // ),
      ],
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}

class CaroselmageWidget extends StatelessWidget {
  final Widget sliderWidget;
  final String slidertext;
  final String slidersecondtext;
  final String count;
  final String? clicktext;
  const CaroselmageWidget({
    required this.sliderWidget,
    required this.slidertext,
    required this.slidersecondtext,
    required this.count,
    this.clicktext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // GooglePoppinsWidgets(text: slidersecondtext, fontsize: 18,color: ),
          //     GooglePoppinsWidgets(text: count, fontsize: 18,color: Colors.black,fontWeight:FontWeight.bold ,)
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: slidertext,
                  fontsize: 15,
                  color: cblack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: slidersecondtext,
                  fontsize: 24,
                  color: Colors.amber,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: count,
                  fontsize: 22,
                  color: cblack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: clicktext!,
                  fontsize: 12,
                  color: cblack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: sliderWidget,
        ),
      ],
    );
  }
}

final List<Widget> graphList = [
  const HomeWorkGraph(),
  const ExamResultGraph(),
  const AttendanceGraphOfStudentPrnt(),
  const StdProjectAndAssignmnetGraph()
];
void _settingModalBottomSheet(context) {
  final studentAttendanceGrpghStatus = Get.put(StudentAttendenceGrpghStatus());
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  FutureBuilder<int>(
      future: studentAttendanceGrpghStatus.fetchStudentAttendenceToParent(),
          builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error:'));
        } else if (snapshot.hasData) {
          final presentDays = snapshot.data!;
     

          return FutureBuilder<int>(
            future: studentAttendanceGrpghStatus.totalWorkingDays(),
            builder: (context, totalDaysSnapshot) {
              if (totalDaysSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (totalDaysSnapshot.hasError) {
                return const Center(child: Text('Error: '));
              } else if (totalDaysSnapshot.hasData) {
                final totalDays = totalDaysSnapshot.data!;
                final absentDays = totalDays - presentDays;
                    final presentPercentage= (presentDays / totalDays) * 100;
                final    absentPercentage = (absentDays / totalDays) * 100;

                
            return SingleChildScrollView(
              child: SizedBox(
                height: 430,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: GooglePoppinsWidgets(
                        text: 'Attendance',
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: cWhite,
                        child: const Stack(
                          alignment: Alignment.center,
                          children: [
                            AttendanceGraphOfStudentPrnt(),
                            Indicator(), // Add the Indicator widget
                          ],
                        ),
                      ),
                    ),
                    Wrap(
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.green[50],
                              child: ListTile(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  leading: const Icon(Icons.check),
                                  title: const Text('Present'),
                                  trailing: GooglePoppinsWidgets(
                                      text:'${presentPercentage.toStringAsFixed(1)}%' , fontsize: 18),
                                  onTap: () => {}),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              color: Colors.red[50],
                              child: ListTile(
                                leading: const Icon(Icons.close),
                                title: const Text('Absent'),
                                trailing:
                                    GooglePoppinsWidgets(text: '${absentPercentage.toStringAsFixed(1)}%', fontsize: 18),
                                onTap: () => {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
               } else {
                return const Center(child: Text('No data available'));
              }
          }
        );
          } else {
          return const Center(child: Text('No data available'));
        }
      }
      );
      }
  );


}
