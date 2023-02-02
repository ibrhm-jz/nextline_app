import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/data/repository/task_repository.dart';
import 'package:nextline_app/ui/constants/colors.dart';
import 'package:nextline_app/ui/utils/responsive.dart';
import 'package:nextline_app/utils/utils.dart';
import 'package:provider/provider.dart';

class CardTask extends StatelessWidget {
  int? index;
  int? id;
  String? title;
  bool? completed;
  DateTime? dueDate;

  CardTask({
    Key? key,
    required this.index,
    required this.id,
    required this.title,
    required this.completed,
    required this.dueDate,
  }) : super(key: key);

  _deleteTask(String id) async {
    TaskRepository _taskRepository = TaskRepository();
    final response = await _taskRepository.deleteTask(id: id);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider _watch = context.watch<TaskProvider>();
    Responsive _responsive = Responsive(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: completed! ? secondaryColor : primaryColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
        height: _responsive.hp(24.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    cardColor: Colors.white,
                  ),
                  child: PopupMenuButton<String>(
                    elevation: 0,
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.grey[500],
                      size: 16,
                    ),
                    onSelected: (value) async {
                      if (value == "delete") {
                        final status = await _deleteTask(id.toString());
                        if (status) {
                          _watch.deleteTask(index: index);
                        }
                      }
                      if (value == "complete") {}
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Eliminar tarea",
                              style: TextStyle(
                                // color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Icon(
                                FontAwesomeIcons.trash,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        value: 'delete',
                      ),
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Completado",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: Icon(
                                FontAwesomeIcons.checkDouble,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        value: 'complete',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            completed!
                ? const Chip(
                    elevation: 0,
                    label: Text('Completado',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.lightGreen,
                  )
                : const Chip(
                    elevation: 0,
                    label: Text('Incompleto',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.redAccent,
                  ),
            const Divider(),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.clock,
                  color: Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 10),
                dueDate != null
                    ? Text(
                        formattDateNumber(dueDate),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const Text(
                        'Sin fecha',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
