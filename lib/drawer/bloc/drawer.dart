import 'package:belajar_bloc/drawer/bloc/drawer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/list_tile_drawer_widget.dart';

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      drawerItems: [
        DrawerItem(title: 'Home', routeName: '/'),
        DrawerItem(
            title: 'Belajar Rest API',
            isExpandable: true,
            subItems: [
              DrawerItem(title: 'Item 1', routeName: '/item1'),
              DrawerItem(title: 'Item 2', routeName: '/item2'),
            ],
            routeName: ''),
        DrawerItem(title: 'Rest API', routeName: '/rest-api'),
      ],
      showExpansionTile: true,
    );
  }
}
