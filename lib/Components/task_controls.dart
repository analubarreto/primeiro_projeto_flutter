import 'package:flutter/material.dart';

class TaskControls extends StatefulWidget {
  final Function onLevelUp;
  final Function onLevelDown;
  final int level;
  final int difficulty;

  TaskControls({
    super.key,
    required this.onLevelUp,
    required this.onLevelDown,
    required this.level,
    required this.difficulty
  });

  @override
  State<TaskControls> createState() => _TaskControlsState();
}

class _TaskControlsState extends State<TaskControls> {
  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
           IconButton(
             onPressed: () => widget.level < widget.difficulty * 10 ? widget.onLevelUp() : null,
             icon: const Icon(Icons.arrow_drop_up),
             color: Colors.green,
             style: ButtonStyle(
               backgroundColor:
                   MaterialStateProperty.all(Colors.green[100]),
               shape: MaterialStateProperty.all(
                 RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8),
                 ),
               ),
             ),
           ),
         IconButton(
           onPressed: () => widget.level > 0 ? widget.onLevelDown() : null,
           icon: const Icon(Icons.arrow_drop_down),
           color: Colors.green,
           style: ButtonStyle(
             backgroundColor:
                 MaterialStateProperty.all(Colors.green[100]),
             shape: MaterialStateProperty.all(
               RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8),
               ),
             ),
           ),
         ),
        ],
      );
  }
}
