import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Estudar flutter'),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(
                          () {
                            todos.add(text);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff00d7f3),
                          fixedSize: Size(100, 100),
                          padding: EdgeInsets.all(14)),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Você possui 0 tarefas pendentes'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      for (String todo in todos)
                        ListTile(
                          title: Text(todo),
                          subtitle: Text('20/11/2020'),
                          onTap: () {
                            print('Tarefa:  $todo');
                          },
                        )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        fixedSize: Size(100, 100),
                        padding: EdgeInsets.all(14)),
                    child: Text('Limpa tudo'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
