import 'package:flutter/material.dart';
import 'package:primeiro_projeto/Components/task_controls.dart';
import 'package:primeiro_projeto/components/difficulty.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/Data/task_dao.dart';
import 'package:primeiro_projeto/Components/delete_dialog.dart';

class Task extends StatefulWidget {
  late String? id;
  final String name;
  final String photo;
  final int difficulty;
  late int? level;

  Task({
    this.id,
    required  this.name,
    required  this.photo,
    required  this.difficulty,
    this.level,
    super.key}) {
    level = level ?? 0;
    id = id ?? '';
  }

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() => widget.photo.contains('http');

  @override
  Widget build(BuildContext context) {
    TaskDao taskDao = TaskDao();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onDoubleTap: () {
          showDialog(context: context, builder: (BuildContext context) {
            return DeleteDialog(dialogContext: context, id: widget.id);
          });
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.deepPurple[300]),
              height: 140,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork() ?
                          Image.network(widget.photo, fit: BoxFit.cover,) :
                          Image.asset(widget.photo, fit: BoxFit.cover,),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                           children: [
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(
                                     width: 200,
                                     child: Text(
                                       widget.name,
                                       style: const TextStyle(
                                         fontSize: 16,
                                         overflow: TextOverflow.ellipsis,
                                       ),
                                     ),
                                 ),
                                 Difficulty(dificultyLevel: widget.difficulty),
                               ],
                             ),
                            TaskControls(
                              level: widget.level,
                              difficulty: widget.difficulty,
                              onLevelUp: () {
                                setState(() {
                                  if (widget.level != null) {
                                    widget.level = widget.level! + 1;
                                    TaskInherited.of(context).updateLevel(widget.level);
                                  }
                                });
                              },
                              onLevelDown: () {
                                setState(() {
                                  if (widget.level != null) {
                                    widget.level = widget.level! - 1;
                                    TaskInherited.of(context).updateLevel(widget.level);
                                  }
                                });
                              },
                            )
                           ],
                          ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.deepPurple,
                          value: (widget.difficulty > 0)
                              ? (widget.level! / widget.difficulty) / 10
                              : 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Nivel: ${widget.level}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}