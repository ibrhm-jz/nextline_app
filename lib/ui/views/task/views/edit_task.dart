import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/data/repository/task_repository.dart';
import 'package:nextline_app/ui/utils/responsive.dart';
import 'package:nextline_app/ui/widgets/fields/default_prefix_field.dart';
import 'package:nextline_app/ui/widgets/loaders/default_progress_dialog.dart';
import 'package:nextline_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final String id;
  final int? index;
  final bool update;
  const EditTask({Key? key, this.id = "", this.update = false, this.index})
      : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final _formKey = GlobalKey<FormState>();
  late TaskProvider _watch;
  bool _loadingTask = false;
  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() async {
    if (widget.update) {
      setState(() => _loadingTask = true);
      TaskRepository _taskRepository = TaskRepository();
      TaskModel _task = await _taskRepository.getTask(id: widget.id);
      context.read<TaskProvider>().onEditTask(
            title: _task.title,
            comments: _task.comments ?? '',
            description: _task.description ?? '',
            completed: _task.getCompleted(),
            tags: _task.tags ?? '',
            date: _task.dueDate,
          );
      setState(() => _loadingTask = false);
    }
  }

  _updateTask() async {
    TaskRepository _taskRepository = TaskRepository();
    Map<String, String> _dataJson =
        await context.read<TaskProvider>().serializeData();
    TaskModel response =
        await _taskRepository.updateTask(body: _dataJson, id: widget.id);
    await context
        .read<TaskProvider>()
        .updateTask(task: response, i: widget.index!);
    Navigator.pop(context);
    context.read<TaskProvider>().clean();
  }

  _createTask() async {
    try {
      TaskRepository _taskRepository = TaskRepository();
      Map<String, String> _dataJson =
          await context.read<TaskProvider>().serializeData();
      TaskModel response = await _taskRepository.createTask(body: _dataJson);

      await context.read<TaskProvider>().createTask(task: response);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveTask() async {
    if (widget.update) {
      await _updateTask();
    } else {
      await _createTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    _watch = Provider.of<TaskProvider>(context);
    Responsive _responsive = Responsive(context);
    return Material(
      child: SizedBox(
        height: _responsive.height - 100,
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: _loadingTask
              ? SizedBox(
                  height: _responsive.height - 100,
                  child: Center(child: DefaultCircularProgress()))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.xmark,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          widget.update
                              ? Text(
                                  'Editar Tarea',
                                  style: Theme.of(context).textTheme.headline1,
                                )
                              : Text(
                                  'Agregar Tarea',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () async {
                              var valid = (_formKey.currentState!.validate());
                              if (!valid) return;
                              await _saveTask();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DefaultPrefixField(
                              controller: _watch.titleController,
                              hintText: 'Titulo',
                              icon: Icons.title,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'El Titulo es Obligatorio';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DefaultPrefixField(
                              controller: _watch.commentsController,
                              hintText: 'Comentarios',
                              maxLines: 2,
                              icon: Icons.comment_sharp,
                            ),
                            const SizedBox(height: 20),
                            DefaultPrefixField(
                              controller: _watch.descriptionController,
                              hintText: 'Descripcion',
                              maxLines: 2,
                              icon: Icons.description,
                            ),
                            const SizedBox(height: 20),
                            DefaultPrefixField(
                              controller: _watch.tagsController,
                              hintText: 'Tags',
                              icon: Icons.tag,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () => pickDateDialog(context),
                                    child: Chip(
                                      label: _watch.selectTime == null
                                          ? Text('Elegir Fecha')
                                          : Text(formattDateNumber(
                                              _watch.selectTime)),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                const Text('Completada'),
                                Checkbox(
                                  checkColor: Colors.white,
                                  // activeColor: ColorSecondary,
                                  value: _watch.isCompleted,
                                  onChanged: (bool? value) {
                                    context
                                        .read<TaskProvider>()
                                        .setCompleted(value: value!);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void pickDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime.utc(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return 'Selecciona fecha';
      }
      context
          .read<TaskProvider>()
          .onDateEdit(date: formattDateSendApi(pickedDate), time: pickedDate);
    });
  }
}
