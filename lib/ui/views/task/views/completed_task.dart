import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/data/repository/task_repository.dart';
import 'package:nextline_app/ui/views/task/skelentons/skelenton_card.dart';
import 'package:nextline_app/ui/views/task/views/edit_task.dart';
import 'package:nextline_app/ui/views/task/widgets/card_task.dart';
import 'package:provider/provider.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({Key? key}) : super(key: key);

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  List<TaskModel> _tasks = [];
  bool _taskLoading = true;
  bool _orderDown = false;
  @override
  void initState() {
    super.initState();
    _getListTask();
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
    context.read<TaskProvider>().setListCompletedTask(_tasks);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tareas completadas.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    onPressed: () {
                      if (_orderDown) {
                        context.read<TaskProvider>().orderAscendent();
                      } else {
                        context.read<TaskProvider>().orderDescendent();
                      }
                      setState(() => _orderDown = !_orderDown);
                    },
                    icon: _orderDown
                        ? const FaIcon(
                            FontAwesomeIcons.arrowDown19,
                            color: Colors.grey,
                            size: 18.0,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.arrowUp19,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _taskLoading
                  ? const Expanded(child: SkeletonCard())
                  : buildView(context),
            ],
          )),
    );
  }

  Widget buildView(BuildContext context) {
    return Flexible(
      child: Consumer<TaskProvider>(
        builder: (_, data, __) => data.getTask.isEmpty
            ? const Center(
                child: Text('No hay tareas completadas.'),
              )
            : ListView.builder(
                itemCount: data.getTask.length,
                itemBuilder: (context, i) {
                  TaskModel _task = data.getTask[i];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => showCupertinoModalBottomSheet<void>(
                          context: context,
                          enableDrag: true,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            return EditTask(
                              id: _task.id.toString(),
                              index: i,
                              update: true,
                            );
                          },
                        ),
                        child: CardTask(
                          index: i,
                          id: _task.id,
                          title: _task.title,
                          completed: _task.getCompleted(),
                          dueDate: _task.dueDate,
                          taskModel: _task,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
