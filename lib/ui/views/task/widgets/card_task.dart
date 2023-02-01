import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextline_app/ui/constants/colors.dart';
import 'package:nextline_app/ui/utils/responsive.dart';
import 'package:nextline_app/utils/utils.dart';

class CardTask extends StatelessWidget {
  String? title;
  String? description;
  bool? completed;
  DateTime? dueDate;

  CardTask({
    Key? key,
    required this.title,
    required this.completed,
    required this.description,
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
      color: primaryColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        height: _responsive.hp(28.0),
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
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.ellipsisVertical,
                    size: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
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
            const SizedBox(height: 10),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.clock,
                  color: Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  formattDateNumber(dueDate),
                  style: const TextStyle(
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
