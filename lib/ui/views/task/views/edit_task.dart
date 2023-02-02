import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextline_app/ui/widgets/fields/default_prefix_field.dart';
import 'package:nextline_app/utils/utils.dart';

class EditTask extends StatefulWidget {
  const EditTask({
    Key? key,
  }) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();
  String? _chosenDate = 'Elegir Fecha';
  DateTime? _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Agregar Tarea',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {},
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
                      controller: _titleController,
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
                      controller: _commentsController,
                      hintText: 'Comentarios',
                      maxLines: 2,
                      icon: Icons.comment_sharp,
                    ),
                    const SizedBox(height: 20),
                    DefaultPrefixField(
                      controller: _descriptionController,
                      hintText: 'Descripcion',
                      maxLines: 2,
                      icon: Icons.description,
                    ),
                    const SizedBox(height: 20),
                    DefaultPrefixField(
                      controller: _tagsController,
                      hintText: 'Tags',
                      icon: Icons.tag,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => pickDateDialog(context),
                            child: Text(_chosenDate!),
                          ),
                        ),
                        const Text('Completada'),
                        Checkbox(
                          checkColor: Colors.white,
                          // activeColor: ColorSecondary,
                          value: true,
                          onChanged: (bool? value) {
                            // setState(() {
                            //   isChecked = value!;
                            // });
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
      setState(() {
        _selectedDate = pickedDate;
        _chosenDate = formattDateNumber(_selectedDate);
      });
    });
  }
}
