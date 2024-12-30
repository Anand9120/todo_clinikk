import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clinikk/models/save_task.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),

      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-todo-screen');
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/posts-screen');
            },
            child: const Icon(Icons.article),
          ),
        ],
      ),
      body: Consumer<SaveTask>(builder: (context,task,child,){
        return task.tasks.isEmpty?const Center(child: Text('Your list is empty !!')):ListView.builder(
          itemCount: task.tasks.length,
            itemBuilder: (BuildContext context,index){

          return ListTile(
            title:  Text(task.tasks[index].title,style: TextStyle(decoration:task.tasks[index].isCompleted?TextDecoration.lineThrough:TextDecoration.none ),),
            trailing: Wrap(
              children: [
                Checkbox(onChanged: (_) {
                  context.read<SaveTask>().checkTask(index);
                },value: task.tasks[index].isCompleted,),
                IconButton(onPressed: (){
                  context.read<SaveTask>().removeTask(task.tasks[index]);
                }, icon:const Icon(Icons.delete))
              ],
            ),
          );
        });
      }),

    );
  }
}
