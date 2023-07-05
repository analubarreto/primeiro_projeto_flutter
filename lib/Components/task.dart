import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;

  Task(this.name, this.photo, this.difficulty, {Key? key})
      : super(key: key);

  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() => widget.photo.contains('http');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                      width: 72,
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
                                       fontSize: 20,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   )),
                               Difficulty(dificultyLevel: widget.difficulty,
                               ),
                             ],
                           ),
                           SizedBox(
                             height: 52,
                             width: 52,
                             child: IconButton(
                               onPressed: () {
                                 setState(() {
                                   if (widget.level < widget.difficulty * 10) widget.level += 1;
                                 });
                               },
                               icon: const Icon(Icons.arrow_drop_up),
                               color: Colors.green,
                               style: ButtonStyle(
                                 backgroundColor:
                                     MaterialStateProperty.all(Colors.green[100]),
                                 shape: MaterialStateProperty.all(
                                   RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15),
                                   ),
                                 ),
                               ),
                             ),
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
                        color: Colors.greenAccent,
                        value: (widget.difficulty > 0)
                            ? (widget.level / widget.difficulty) / 10
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
    );
  }
}