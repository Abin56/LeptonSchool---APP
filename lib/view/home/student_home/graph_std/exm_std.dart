import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lepton_school/controllers/graph_controller/exam_graph/std_exam_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExamGraphOfStd extends StatelessWidget {
  ExamGraphOfStd({super.key});

  final StudentExamResultGraphController controller =
      Get.put(StudentExamResultGraphController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchExams(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        controller.getStudentExamStatus().then((value) => controller.examgraphData());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<String> exams = snapshot.data ?? [];
       
          return FutureBuilder(
            future: Future.wait(exams.map((exam) async {
              final passCount =await controller.examgraphData().then((value) => value['studentExamPassTotalCount']);
              final failCount =await controller.examgraphData().then((value) => value['studentExamFailedTotalCount']);
              final totalExams =await controller.examgraphData().then((value) => value['totalExamCount']);
              

              return ChartData(
                "Exam",
                totalExams!.toDouble(),
                passCount!.toDouble(),
                failCount!.toDouble(),
              );
            })),
            builder: (context, AsyncSnapshot<List<ChartData>> chartSnapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${chartSnapshot.error}'));
              } else {
                final List<ChartData> chartData = chartSnapshot.data ?? [];
              

                return SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(minimum: 0, maximum: 50, interval: 5),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      dataSource: chartData,
                      width: 1,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Total Exams',
                    ),
                    ColumnSeries<ChartData, String>(
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      dataSource: chartData,
                      width: 1,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y1,
                      pointColorMapper: (ChartData data, _) =>
                          data.y >= data.y1 ? Colors.green : Colors.red,
                      name: 'Passed Exams',
                    ),
                    ColumnSeries<ChartData, String>(
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      dataSource: chartData,
                      width: 1,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y2,
                      pointColorMapper: (ChartData data, _) =>
                          data.y1 > 0 ? Colors.red : Colors.transparent,
                      name: 'Failed Exams',
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);

  final String x;
  final double y; // Total exams
  final double y1; // Passed exams
  final double y2; // Failed exams
}

class ExamResultGraph extends StatelessWidget {
  const ExamResultGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Adjust height as needed
      width: double.infinity,
      color: Colors.white,
      child: ExamGraphOfStd(),
    );
  }
}
