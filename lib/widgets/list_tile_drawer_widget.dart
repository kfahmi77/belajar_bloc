import 'package:belajar_bloc/drawer/bloc/drawer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> drawerItems;
  final bool showExpansionTile;

  const CustomDrawer({Key? key, required this.drawerItems, this.showExpansionTile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerBloc = BlocProvider.of<DrawerBloc>(context);

    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              for (var item in drawerItems)
                if (item.isExpandable && showExpansionTile)
                  ExpansionTile(
                    title: Text(item.title),
                    children: [
                      for (var subItem in item.subItems!)
                        ListTile(
                          title: Text(subItem.title),
                          selected: ModalRoute.of(context)!.settings.name == subItem.routeName,
                          selectedTileColor: Colors.blue[100],
                          onTap: () {
                            drawerBloc.add(const CloseDrawer());
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(subItem.routeName);
                          },
                        ),
                    ],
                  )
                else
                  ListTile(
                    title: Text(item.title),
                    selected: ModalRoute.of(context)!.settings.name == item.routeName,
                    selectedTileColor: Colors.blue[100],
                    onTap: () {
                      drawerBloc.add(const CloseDrawer());
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(item.routeName);
                    },
                  ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerItem {
  final String title;
  final String routeName;
  final bool isExpandable;
  final List<DrawerItem>? subItems;

  DrawerItem({required this.title, required this.routeName, this.isExpandable = false, this.subItems});
}
