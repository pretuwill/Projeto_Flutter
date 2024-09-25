import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userName;

  ProfilePage({required this.userName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime _currentDate = DateTime.now();
  List<bool> _taskStatus = [false, false, false];
  List<String> _tasks = [
    'Ir à academia',
    'Tomar dois litros de água',
    'Ler 10 páginas de um livro'
  ];
  TextEditingController _newTaskController = TextEditingController();

  // Função para adicionar nova tarefa
  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
      _taskStatus.add(false);
    });
    _newTaskController.clear();
  }

  // Função para remover tarefa
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _taskStatus.removeAt(index);
    });
  }

  // Função para reordenar tarefas
  void _reorderTasks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final task = _tasks.removeAt(oldIndex);
      final status = _taskStatus.removeAt(oldIndex);
      _tasks.insert(newIndex, task);
      _taskStatus.insert(newIndex, status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 59, 65, 71),
      ),
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${widget.userName}!',
              style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Data: ${_currentDate.day}/${_currentDate.month}/${_currentDate.year}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Suas tarefas do dia:',
              style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ReorderableListView(
                onReorder: _reorderTasks,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: List.generate(_tasks.length, (index) {
                  return Dismissible(
                    key: Key('$index-${_tasks[index]}'),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _removeTask(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      key: ValueKey('$index-${_tasks[index]}'),
                      leading: IconButton(
                        icon: _taskStatus[index]
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.check_circle_outline, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            _taskStatus[index] = !_taskStatus[index];
                          });
                        },
                      ),
                      title: Text(
                        _tasks[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(Icons.drag_handle, color: Colors.green),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newTaskController,
              decoration: InputDecoration(
                hintText: 'Adicionar nova tarefa',
                hintStyle: TextStyle(color: Colors.green),
                filled: true,
                fillColor: Colors.white12,
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    if (_newTaskController.text.isNotEmpty) {
                      _addTask(_newTaskController.text);
                    }
                  },
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
