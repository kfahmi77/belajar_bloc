part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {
  final bool isOpen;

  const DrawerInitial({this.isOpen = false});

  @override
  List<Object> get props => [isOpen];
}
