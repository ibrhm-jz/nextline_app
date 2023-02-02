import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/ui/widgets/fields/default_prefix_field.dart';
import 'package:nextline_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final String title;
  final String comments;
  final String description;
  final String date;
  final String tags;
  final bool completed;
  final bool update;
  const EditTask({
    Key? key,
    this.title = "",
    this.comments = "",
    this.description = "",
    this.date = "Elegir fecha",
    this.tags = "",
    this.completed = false,
    this.update = false,
  }) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final _formKey = GlobalKey<FormState>();
  String? _chosenDate = 'Elegir Fecha';
  DateTime? _selectedDate = DateTime.now();
  late TaskProvider _watch;
  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    if (widget.update) {
      context.read<TaskProvider>().onEditTask(
            title: widget.title,
            comments: widget.comments,
            description: widget.description,
            completed: widget.completed,
            tags: widget.tags,
            date: widget.date,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    _watch = Provider.of<TaskProvider>(context);
    return Material(
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Column(
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
                    onPressed: () {
                      var valid = (_formKey.currentState!.validate());
                      if (!valid) return;
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
                            child: Chip(label: Text(_watch.chosenDate)),
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
          .onDateEdit(date: formattDateNumber(pickedDate), time: pickedDate);
    });
  }
}
