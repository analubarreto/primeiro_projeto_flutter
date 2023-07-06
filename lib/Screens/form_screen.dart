import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';

class FormScreen extends StatefulWidget {

  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isNullOrEmpty(String? value) => value != null && value.isEmpty;
  bool difficultyValidator(String? value) => value != null && int.parse(value) > 5 && int.parse(value) < 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 650,
              width: 375,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Container(
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                         child: TextFormField(
                           validator: (String? value) {
                             if (isNullOrEmpty(value)) return 'Insira o nome da Tarefa';
                             return null;
                           },
                           controller: nameController,
                           decoration: const InputDecoration(
                             hintText: 'Nome',
                             fillColor: Colors.white70,
                             filled: true,
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                         child: TextFormField(
                           validator: (value) {
                             if (difficultyValidator(value)) return 'Insira um Dificuldade entre 1 e 5';
                             return null;
                           },
                           keyboardType: TextInputType.number,
                           controller: difficultyController,
                           decoration: const InputDecoration(
                             hintText: 'Dificuldade',
                             fillColor: Colors.white70,
                             filled: true,
                           ),
                         ),
                       ),
                       Padding(
                         padding:const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                         child: TextFormField(
                           onChanged: (text) {
                             setState(() {});
                           },
                           validator: (value){
                             if(isNullOrEmpty(value)) return 'Insira um URL de Imagem!';
                             return null;
                           },
                           keyboardType: TextInputType.url,
                           controller: imageController,
                           decoration: const InputDecoration(
                             hintText: 'Imagem',
                             fillColor: Colors.white70,
                             filled: true,
                           ),
                         ),
                       ),
                     ],
                   )
                 ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.deepPurple),
                    ),
                    child: imageController.text.isEmpty
                          ? const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.deepPurple,
                            )
                          : Image.network(
                              imageController.text,
                              fit: BoxFit.contain,
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          TaskInherited.of(context).newTask(
                            nameController.text,
                            imageController.text,
                            int.parse(difficultyController.text),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tarefa Adicionada!'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Adicionar!'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
