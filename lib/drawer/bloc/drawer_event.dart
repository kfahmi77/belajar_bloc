part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

class OpenDrawer extends DrawerEvent {
  final bool isOpen;

  const OpenDrawer({this.isOpen = true});

  @override
  List<Object> get props => [isOpen];
}

class CloseDrawer extends DrawerEvent {
  final bool isOpen;

  const CloseDrawer({this.isOpen = false});

  @override
  List<Object> get props => [isOpen];
}
