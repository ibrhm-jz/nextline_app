import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/data/repository/task_repository.dart';
import 'package:nextline_app/ui/utils/responsive.dart';
import 'package:nextline_app/ui/views/chart/widgets/indicator.dart';
import 'package:nextline_app/ui/widgets/loaders/default_progress_dialog.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<TaskModel> _tasks = [];
  bool _taskLoading = true;
  int touchedIndex = -1;
  late TaskProvider _watch;
  @override
  void initState() {
    _getListTask();
    super.initState();
  }

  _getListTask() async {
    TaskRepository _taskRepository = TaskRepository();
    final response = await _taskRepository.getListTask();
    setState(() {
      _tasks = response;
      _taskLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<TaskProvider>().setListTask(_tasks);
    _watch = Provider.of<TaskProvider>(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rendimiento de tareas.',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20),
            _taskLoading
                ? Expanded(child: Center(child: DefaultCircularProgress()))
                : Container(
                    child: _watch.taskList.isEmpty
                        ? const Center(
                            child: Text('Aun no hay datos para mostrar'),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total de tareas:' +
                                    _watch.getTaskLengt.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 40),
                              const Indicator(
                                color: Colors.indigo,
                                text: 'Tareas completada',
                                isSquare: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Indicator(
                                color: Colors.red,
                                text: 'Tareas Inompletas',
                                isSquare: true,
                              ),
                              const SizedBox(height: 40),
                              AspectRatio(
                                aspectRatio: 1.3,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 0,
                                      sections: showingSections(context),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(BuildContext context) {
    Responsive _responsive = Responsive(context);
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? _responsive.wp(35) : _responsive.wp(30);
      TextStyle _style = TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.indigo,
            value: double.parse(
              _watch.getTaskCompleted.toString(),
            ),
            title: _watch.getTaskCompleted.toString(),
            radius: radius,
            titleStyle: _style,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: double.parse(
              _watch.getTaskIncompleted.toString(),
            ),
            title: _watch.getTaskIncompleted.toString(),
            radius: radius,
            titleStyle: _style,
          );

        default:
          throw Error();
      }
    });
  }
}
