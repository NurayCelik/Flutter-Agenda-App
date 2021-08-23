import '../screens/agenda_list_screen.dart';
import '../screens/add_agenda_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        //Drawer widgetı yazmazsak tam ekranlı drawer olur.
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF7babdc),
                  Colors.purple.shade300,
                ],
                stops: [
                  0.0,
                  1.0
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomLeft,
                tileMode: TileMode.repeated),
          ),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Ajanda App",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
                accountEmail: Text(
                  "Pratik & Kolay Todo Uygulaması",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(),
              ),
              ListTile(
                title: Text("Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                leading: Icon(
                  Icons.home,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Not Listesi",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                leading: Icon(Icons.list),
                onTap: () {
                  Navigator.of(context).pushNamed(AgendaListScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Not Ekle",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.of(context).pushNamed(AddAgendaScreen.routeName,
                      arguments: {'isAdd': null, 'userId': null});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
