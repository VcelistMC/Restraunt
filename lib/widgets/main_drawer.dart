import 'package:flutter/material.dart';
import 'package:meal_application/screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Text("cooking up lol"),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 30,
          ),
          ListTileItem("Meals", Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          ListTileItem("Filters", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          })
        ],
      ),
    );
  }
}
class ListTileItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function tabHandler;

  const ListTileItem(this.title, this.icon, this.tabHandler);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title),
      onTap: tabHandler,
    );
  }
}
