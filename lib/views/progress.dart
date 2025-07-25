import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../core/services/exercises/user_progress_service.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  static const routeName = 'ProgressPage';

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  List<_progressData> originalData = [];
  late ZoomPanBehavior _zoomPanBehavior;
  bool _isLoading = true;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    super.initState();
    initPlatformState();
    fetchProgress();
  }

  Future<void> fetchProgress() async {
    try {
      final progressList = await UserProgressService().getUserProgress();
      setState(() {
        originalData = progressList
            .map((e) => _progressData(e.dayNumber.toString(), e.completedExercises))
            .toList();
        _isLoading = false;

        // DEBUG: Print full progress data
        for (var i in progressList) {
          debugPrint('--- User Progress Entry ---');
          debugPrint('Day Number: ${i.dayNumber}');
          debugPrint('Total Exercises: ${i.totalExercises}');
          debugPrint('Completed Exercises: ${i.completedExercises}');
          debugPrint('----------------------------');
        }
      });
    } catch (e) {
      print('❌ Failed to fetch user progress: $e');
      setState(() => _isLoading = false);
    }
  }


  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() ==
          PermissionStatus.granted;
    }

    return granted;
  }

  Future<void> initPlatformState() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) return;

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int lastNonZeroIndex = originalData.lastIndexWhere((d) => d.workout != 0);
    List<_progressData> data = originalData.sublist(0, lastNonZeroIndex + 1);

    return Scaffold(
      appBar: CustomAppbar(title: "Progress Tracker"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          width: double.infinity,
                          Assets.assetsImagesProgress,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 7,
                      left: 20,
                      child: Text(
                        "Your \nProgress \nPlan",
                        style: TextStyle(
                          color: lightButtonTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: isDark ? darkBmiContainerColor : lightBmiContainerColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isDark ? darkAppbarBackBorderColor : lightAppbarBackBorderColor,
                    width: 2.5,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? darkCardColor : lightCardColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isDark ? darkAppbarBackBorderColor : lightAppbarBackBorderColor,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Steps',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? darkCardTextColor : lightCardTextColor,
                              ),
                            ),
                            Divider(
                              height: 20,
                              color: isDark ? darkButtonTextColor : lightButtonTextColor,
                            ),
                            Text(
                              _steps,
                              style: TextStyle(
                                fontSize: 20,
                                color: isDark ? darkBmiTextColor_1 : lightBmiTextColor_1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? darkCardColor : lightCardColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isDark ? darkAppbarBackBorderColor : lightAppbarBackBorderColor,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SfCartesianChart(
                                  primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    maximum: 10,
                                    majorGridLines: MajorGridLines(
                                      color: isDark? darkButtonTextColor : lightButtonTextColor
                                    ),
                                    interval: 1,
                                    title: AxisTitle(
                                      text: "Number of Exercises",
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: isDark? darkButtonTextColor : lightButtonTextColor,
                                        fontWeight: FontWeight.bold
                                    )
                                    ),
                                    labelStyle: TextStyle(
                                      color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                                    ),
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(text: "Day" , textStyle: TextStyle(
                                      fontSize: 15,
                                      color: isDark? darkButtonTextColor : lightButtonTextColor,
                                      fontWeight: FontWeight.bold
                                    )),
                                    interval: 1,
                                    labelPlacement: LabelPlacement.onTicks,
                                    majorGridLines: MajorGridLines(
                                        color: isDark? darkButtonTextColor : lightButtonTextColor
                                    ),
                                    initialVisibleMinimum: data.length > 10 ?
                                    data.length -10 : 0,
                                    initialVisibleMaximum: data.length - 1,
                                    labelStyle: TextStyle(
                                      color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                                    ),
                                  ),
                                  zoomPanBehavior: _zoomPanBehavior,
                                  title: ChartTitle(
                                    text: 'Your Progress' ,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                                    )
                                    ),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  palette: [isDark? darkBmiTextColor_1 : lightBmiTextColor_1],
                                  plotAreaBorderColor: Colors.grey,
                                  borderColor: Colors.grey,
                                  series: <CartesianSeries<_progressData, String>>[
                                    LineSeries<_progressData, String>(
                                        dataSource: data,
                                        xValueMapper: (_progressData data, _) => data.day,
                                        yValueMapper: (_progressData data, _) => data.workout,
                                        name: 'number of workout',
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: false ,
                                          ))
                                  ]
                                ),
                              ),
                            )
                          ],
                        ),
                        ),
                    ),
                  ],
                ),
                )
              ),
            SizedBox(height: 15,)
          ],
        )
      ),
    );
  }
}

class _progressData {
  _progressData(this.day, this.workout);
  final String day;
  final int workout;
}
