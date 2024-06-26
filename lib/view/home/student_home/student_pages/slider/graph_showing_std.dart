import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lepton_school/controllers/graph_controller/students_Graph/attendence_grphStatus.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:lepton_school/view/home/student_home/graph_std/assignment_project_std.dart';
import 'package:lepton_school/view/home/student_home/graph_std/attendance_std_g.dart';
import 'package:lepton_school/view/home/student_home/graph_std/exm_std.dart';
import 'package:lepton_school/view/home/student_home/graph_std/homework_std_g.dart';
import 'package:lepton_school/view/home/student_home/student_pages/on_click_std_details/attendance_bottomsheet.dart';
import 'package:lepton_school/view/widgets/fonts/google_poppins.dart';

class GraphShowingPartStdAttendance extends StatefulWidget {
   const GraphShowingPartStdAttendance({super.key});

  @override
  State<GraphShowingPartStdAttendance> createState() => _GraphShowingPartStdAttendanceState();
}

class _GraphShowingPartStdAttendanceState extends State<GraphShowingPartStdAttendance> {
 late Future<int> _fetchPresentDays;
  late Future<int> _fetchTotalDays;
    @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final studentAttendenceGrpghStatus = Get.put(StudentAttendenceGrpghStatus());
    _fetchPresentDays = studentAttendenceGrpghStatus.fetchStudentAttendence();
    _fetchTotalDays = studentAttendenceGrpghStatus.totalWorkingDays();
  }

  @override
  Widget build(BuildContext context) {
 
    return GestureDetector(
      onTap: () => attendanceOnClickDetailsShowing(),
      child: Container(
        height: 100.h,
        decoration: const BoxDecoration(
          boxShadow: [ BoxShadow(
            color: cblack,
          ),
        ], 
        color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: FutureBuilder<int>(
          future: _fetchPresentDays,
          builder: (context, snapshotPresentDays) {
            if (snapshotPresentDays.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshotPresentDays.hasError) {
              return Center(child: Text('Error: ${snapshotPresentDays.error}'));
            }

            final presentDays = snapshotPresentDays.data ?? 0;

            return FutureBuilder<int>(
              future: _fetchTotalDays,
              builder: (context, snapshotTotalDays) {
                if (snapshotTotalDays.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshotTotalDays.hasError) {
                  return Center(child: Text('Error: ${snapshotTotalDays.error}'));
                }

                final totalDays = snapshotTotalDays.data ?? 0;
                // log('Present Days: $presentDays');
                // log('Total Days: $totalDays');
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 08),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40.h,
                          child: Image.asset(
                              'assets/flaticons/icons8-attendance-100.png'),
                        ),
                        Text(
                          '  Attendance',
                          style: TextStyle(
                              color:  const Color.fromARGB(255, 11, 2, 74),
                              //const Color.fromARGB(255, 48, 88, 86),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 05, left: 20),
                    child: Text(
                      'AVERAGE',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 228, 173, 21),
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 05, left: 25),
                    child: Text(
                      ' $presentDays'"/"' $totalDays',
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,top: 05),
                    child: GooglePoppinsWidgets(text: "Click To View", fontsize: 13,fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
             const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: AttendanceGraphOfStudent(),
              ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class GraphShowingPartStdHomework extends StatelessWidget {
  const GraphShowingPartStdHomework({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: cblack,
        ),
      ], color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 08),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: Image.asset(
                            'assets/flaticons/icons8-homework-100.png'),
                      ),
                      Text(
                        '  Homework',
                        style: TextStyle(
                            color: 
                            const Color.fromARGB(255, 48, 88, 86),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 20),
                  child: Text(
                    'AVERAGE',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 228, 173, 21),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 25),
                  child: Text(
                    '200/300',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: HomeWorkGraphOfStd(  pending: 5,
        completed: 15,
        //total: 21,
        ),
            ),
          ),
        ],
      ),
    );
  }
}


class GraphShowingPartStdExamResult extends StatelessWidget {
  const GraphShowingPartStdExamResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: cblack,
        ),
      ], color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 08),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: Image.asset(
                            'assets/flaticons/icons8-grades-100.png'),
                      ),
                      Text(
                        '  Exam Result',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 11, 2, 74),
                            // const Color.fromARGB(255, 48, 88, 86),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 20),
                  child: Text(
                    'AVERAGE',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 228, 173, 21),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 25),
                  child: Text(
                    '200/300',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child:    AssignmentProjectGraph(),

            ),
          ),
        ],
      ),
    );
  }
}


class GraphShowingPartStdAssignProject extends StatelessWidget {
  const GraphShowingPartStdAssignProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: cblack,
        ),
      ], color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 08),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: Image.asset(
                            'assets/flaticons/exam.png'),
                      ),
                      Text(
                        '  Assignments\n & Projects',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 48, 88, 86),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 20),
                  child: Text(
                    'AVERAGE',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 228, 173, 21),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 05, left: 25),
                  child: Text(
                    '200/300',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: ExamGraphOfStd(),
            ),
          ),
        ],
      ),
    );
  }
}