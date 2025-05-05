import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  List <_progressData> data = [
    _progressData("1", 5),
    _progressData("2", 4),
    _progressData("3", 3),
    _progressData("4", 6),
    _progressData("5", 7),
    _progressData("6", 8),
    _progressData("7", 5),
    _progressData("8", 4),
    _progressData("9", 2),
    _progressData("10", 3),
    _progressData("11", 4),
    _progressData("12", 5),
    _progressData("13", 6),
    _progressData("14", 7),
    _progressData("15", 9),
    _progressData("16", 2),
    _progressData("17", 1),
    _progressData("18", 8),
    _progressData("19", 5),
  ];

  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
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
    if (!granted) {
      // tell user, the app will not work
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(title: "Progress Tracker"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          width: double.infinity,
                          Assets.assetsImagesProgress ,
                          fit: BoxFit.cover,
                          ),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 20,
                      child: Text(
                      "Your \nProgress \nPlan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ))
                  ],
                ),
              )
              ),
            SizedBox(height: 20,),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Color(0xFFB7B9BB),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Steps',
                              style: TextStyle(fontSize: 20
                              , fontWeight: FontWeight.bold,
                              color: Colors.black
                              ),
                            ),
                            Divider(
                              height: 20,
                              color: Colors.white,
                            ),
                            Text(
                              _steps,
                              style: TextStyle(fontSize: 20,
                              color: Colors.blue),
                            ),
                          ],
                        )
                        ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SfCartesianChart(
                                  primaryYAxis: NumericAxis(
                                    majorGridLines: MajorGridLines(
                                      color: Colors.grey[300]
                                    ),
                                    interval: 1,
                                    title: AxisTitle(
                                      text: "Number of Exercises",
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue
                                    )
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black
                                    ),
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(text: "Day" , textStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue
                                    )),
                                    interval: 1,
                                    labelPlacement: LabelPlacement.onTicks,
                                    majorGridLines: MajorGridLines(
                                      color: Colors.grey[300]
                                    ),
                                    initialVisibleMinimum: data.length > 10 ?
                                    data.length -10 : 0,
                                    initialVisibleMaximum: data.length - 1,
                                    labelStyle: TextStyle(
                                      color: Colors.black
                                    ),
                                  ),
                                  zoomPanBehavior: _zoomPanBehavior,
                                  title: ChartTitle(
                                    text: 'Your Progress' ,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black
                                    )
                                    ),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  palette: [Colors.blue],
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
                                          textStyle: TextStyle(
                                            color: Colors.black
                                          )
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
  _progressData(this.day , this.workout);

  final String day;
  final int workout;
}