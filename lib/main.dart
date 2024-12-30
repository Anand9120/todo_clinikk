import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_clinikk/models/save_task.dart';
import 'package:todo_clinikk/pages/add_todo.dart';
import 'package:todo_clinikk/pages/post_screen.dart';
import 'package:todo_clinikk/pages/todo_list.dart';
import 'package:todo_clinikk/pages/splash_screen.dart'; // Import the splash screen.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaveTask(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String initialRoute = '/splash';
  static const String todoListRoute = '/';
  static const String addTodoRoute = '/add-todo-screen';
  static const String postsScreenRoute = '/posts-screen';

  @override
  Widget build(BuildContext context) {
   return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: initialRoute,
      routes: {
        initialRoute: (_) => const SplashScreen(),
        todoListRoute: (_) => const TodoList(),
        addTodoRoute: (_) => AddTodo(),
        postsScreenRoute: (_) => const PostsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404: Page Not Found'),
            ),
          ),
        );
      },
    )
    );
  }
}
