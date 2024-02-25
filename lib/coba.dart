import 'dart:math';

import 'package:belajar_bloc/drawer/bloc/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

// Model Data
class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}

// Repository
abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class DioPostRepository implements PostRepository {
  final Dio dio;

  DioPostRepository({required this.dio});

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      final List<dynamic> data = response.data;
      return data
          .map((json) =>
              Post(id: json['id'], title: json['title'], body: json['body']))
          .toList();
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }
}

// Use Case
class GetPosts {
  final PostRepository repository;

  GetPosts({required this.repository});

  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}

// State dan Event
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {}

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {}

// Bloc
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;

  PostBloc({required this.getPosts}) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await getPosts();
        emit(PostLoaded(posts: posts));
      } catch (e) {
        emit(PostError());
      }
    });
  }
}

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          BlocProvider.of<PostBloc>(context).add(FetchPosts());
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        } else if (state is PostError) {
          return Center(child: Text('Failed to load posts'));
        } else {
          return Container();
        }
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      drawer: DrawerBuilder(),
      body: PostListWidget(),
    );
  }
}
