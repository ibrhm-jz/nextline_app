import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextline_app/ui/constants/constants.dart';
import 'package:nextline_app/ui/utils/responsive.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todas las tareas.',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: primaryColor,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: _responsive.hp(32.0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Football',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ligue 1 opener posponed after Marseille virus cases.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    const Chip(
                      label: Text('Completo',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.lightGreen,
                    ),
                    // Row(
                    //   children: const [
                    //     FaIcon(
                    //       FontAwesomeIcons.locationPin,
                    //       color: Colors.blue,
                    //     ),
                    //     SizedBox(width: 10),
                    //     Text(
                    //       'Marolowe',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.blue,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.black,
                        ),
                        Text(
                          '10:00 AM - 10:30 PM',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 1,
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
