import 'package:belajar_bloc/core/routes.dart';
import 'package:belajar_bloc/note_app/data/datasources/task_remote_datasource.dart';
import 'package:belajar_bloc/note_app/bloc/add_task/add_task_bloc.dart';
import 'package:belajar_bloc/note_app/bloc/get_task/get_task_bloc.dart';
import 'package:belajar_bloc/note_app/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coba.dart';
import 'drawer/bloc/drawer_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerBloc()),
        BlocProvider(
          create: (context) => PostBloc(
              getPosts: GetPosts(repository: DioPostRepository(dio: Dio()))),
        ),
        BlocProvider(
          create: (context) => GetTaskBloc(TaskRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddTaskBloc(TaskRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute),
    );
  }
}
