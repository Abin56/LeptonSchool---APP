import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lepton_school/controllers/graph_controller/parent_Graphs/home_work_graph.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeWorkGraphOfPrnt extends StatefulWidget {
  const HomeWorkGraphOfPrnt(
      {super.key,
      required this.completed,
      required this.pending,
      required this.total});

  final int completed;
  final int pending;
  final int total;

  @override
  State<HomeWorkGraphOfPrnt> createState() => _HomeWorkGraphOfPrntState();
}

class _HomeWorkGraphOfPrntState extends State<HomeWorkGraphOfPrnt> {
  final StudentHomeWorkGraphController homewrokController = Get.put(StudentHomeWorkGraphController());

  @override
  void initState() {
    super.initState();
    homewrokController.fetchHomeWorkData();
  }
  @override
  Widget build(BuildContext context) {
     return Obx(() {
      final completed = homewrokController.completedHomeWorkCount.value;
      final total = homewrokController.totalHomeWorkCount.value;
      final pending = total - completed;

      final List<ChartData> chartData = [
        ChartData('Completed', completed.toDouble(), const Color.fromARGB(255, 65, 125, 252)),
        ChartData('Pending', pending.toDouble(), const Color.fromARGB(255, 255, 0, 0)),
      ];

    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height:'100%', // Setting height and width for the circular chart annotation
            width: '100%',
            widget: PhysicalModel(
                shape: BoxShape.circle,
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(230, 230, 230, 1),
                child: Container())),

        CircularChartAnnotation(
            widget: Text(total.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 23))),

                
      ],
      series: <DoughnutSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
          innerRadius: '40%',
          dataSource: chartData,
          animationDuration: 1,
          dataLabelSettings:   DataLabelSettings(
            textStyle:  TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),
            isVisible: true),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (data, index) => data.color,
        )
      ],
    );
      });//
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class HomeWorkGraphPrnt extends StatelessWidget {
  const HomeWorkGraphPrnt({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentHomeWorkGraphController homewrkCntrl = Get.put(StudentHomeWorkGraphController());

    return Obx(() {
      final completed = homewrkCntrl.completedHomeWorkCount.value;
      final total = homewrkCntrl.totalHomeWorkCount.value;
      final pending = total - completed;

      return Container(
        height: 250,
        width: 250,
        color: cWhite,
        child: HomeWorkGraphOfPrnt(
        pending: pending,
        completed: completed,
        total: total,
      ),
    );
     });
  }
}
