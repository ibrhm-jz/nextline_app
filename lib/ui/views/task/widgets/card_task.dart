import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextline_app/ui/constants/colors.dart';
import 'package:nextline_app/ui/utils/responsive.dart';
import 'package:nextline_app/utils/utils.dart';

class CardTask extends StatelessWidget {
  String? title;

  bool? completed;
  DateTime? dueDate;

  CardTask({
    Key? key,
    required this.title,
    required this.completed,
    required this.dueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive _responsive = Responsive(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: completed! ? secondaryColor : primaryColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        height: _responsive.hp(25.0),
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
                      // if (value == "delete") {}
                      // if (value == "complete") {}
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
                                // color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: Icon(
                                FontAwesomeIcons.checkDouble,
                                // color: Colors.grey[600],
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
