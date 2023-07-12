import 'package:flutter/material.dart';
import 'package:primeiro_projeto/Data/task_dao.dart';

class DeleteDialog extends StatelessWidget {
  late int? id;
  final BuildContext dialogContext;

  DeleteDialog({ this.id, required this.dialogContext, super.key});

  @override
  Widget build(BuildContext dialogContext) {
    TaskDao taskDao = TaskDao();

    return AlertDialog(
      title: const Text('Deletar tarefa'),
      content: const Column(
        children: [
          Icon(Icons.warning_rounded, color: Colors.red, size: 50,),
          Text('Tem certeza que deseja deletar a tarefa?'),
          Text('Essa ação não pode ser desfeita!'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await taskDao.delete(id);
            Navigator.pop(dialogContext);
          },
          child: const Text('Deletar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
