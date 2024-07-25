import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lepton_school/controllers/graph_controller/attendance_Graph/attendence_grphStatus.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AttendanceGraphOfStudent extends StatefulWidget {
   const AttendanceGraphOfStudent({super.key});

  @override
  State<AttendanceGraphOfStudent> createState() => _AttendanceGraphOfStudentState();
}

class _AttendanceGraphOfStudentState extends State<AttendanceGraphOfStudent> {
final StudentAttendenceGrpghStatus studentAttendenceGrpghStatus = Get.put(StudentAttendenceGrpghStatus());                        

 double presentPercentage = 0.0;
  double absentPercentage = 0.0;
  bool isLoading = true;

    @override
  void initState() {
    super.initState();
    _fetchAttendanceDataTo();
  }

 
  Future<void> _fetchAttendanceDataTo() async {
    final studentAttendenceGrpghStatus = Get.put(StudentAttendenceGrpghStatus());
    final presentDays = await studentAttendenceGrpghStatus.fetchStudentAttendence();
    final totalDays = await studentAttendenceGrpghStatus.totalWorkingDays();
    setState(() {
      presentPercentage = (presentDays / totalDays) * 100;
      absentPercentage = totalDays - presentPercentage;
      isLoading = false;
      //  log("Present Percentage: $presentPercentage");
      // log("Absent Percentage: $absentPercentage");
    });
  }
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          radiusFactor: 0.9,
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: true,
          interval: 8,
          ticksPosition: ElementsPosition.inside,
          tickOffset: 10,
          majorTickStyle: const MajorTickStyle(color: Colors.red, length: 0.5),
          minorTickStyle: const MinorTickStyle(color: Colors.white),
          axisLineStyle: const AxisLineStyle(
            thickness: 0.3,
            cornerStyle: CornerStyle.bothFlat,
            color: Color.fromARGB(255, 137, 238, 140),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers:  <GaugePointer>[
            RangePointer(
              color: Colors.blue,
              value: presentPercentage,
              cornerStyle: CornerStyle.endCurve,
              width: 0.3,
              sizeUnit: GaugeSizeUnit.factor,
            ),
          ],
          annotations:  <GaugeAnnotation>[
            GaugeAnnotation(
              axisValue: presentPercentage,
              positionFactor: 0.2,
              widget: Text( '${presentPercentage.toStringAsFixed(1)}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ])
    ]);
  }
}

class AttendanceGraph extends StatelessWidget {
  const AttendanceGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: cWhite,
      child:  const AttendanceGraphOfStudent(),
    );
  }
}
