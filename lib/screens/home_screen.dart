import './add_agenda_screen.dart';
import '../providers/agendas.dart';
import './agenda_list_screen.dart';
import '../widgets/agenda_grid.dart';
import '../widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Notlar,
  Home,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); //  WON'T WORK
    // Future.delayed(Duration.zero).then((_) { // this is work
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Agendas>(context).fetchAndSetAgendas();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xffe8f4ff),
            size: 50.0,
          ),
          automaticallyImplyLeading: true, // hides default back button
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 1.0],
                  tileMode: TileMode.clamp,
                  colors: [
                    Color(0xFF7babdc),
                    Colors.purple.shade300,
                  ]),
            ),
            alignment: Alignment.center,
            child: Text(
              'Ajanda App',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xffe8f4ff), //Theme.of(context).primaryColor
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontFamily: "Quicksand-bold",
              ),
            ),
          ),
          title: Text(''),
          centerTitle: true,

          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Notlar) {
                    Navigator.of(context).pushNamed(AgendaListScreen.routeName);
                  } else {}
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Ajanda Listesi'),
                  value: FilterOptions.Notlar,
                ),
                PopupMenuItem(
                  child: Text('Home'),
                  value: FilterOptions.Home,
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: DrawerNavigation(),
      body: Provider.of<Agendas>(context).isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AgendaGrid(),
          floatingActionButton: FloatingActionButton(
        child: Icon(
           Icons.add_circle,
        ),
        onPressed: () => Navigator.of(context).pushNamed(AddAgendaScreen.routeName,
                  arguments: {'isAdd': null, 'userId': null})
      ),
    );
  }
}
