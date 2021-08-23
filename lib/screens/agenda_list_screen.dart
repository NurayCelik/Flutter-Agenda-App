import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/agendas.dart';
import './add_agenda_screen.dart';
import '../widgets/agenda_list_item.dart';

class AgendaListScreen extends StatefulWidget {
  static const routeName = '/list-screen';
  @override
  _AgendaListScreenState createState() => _AgendaListScreenState();
}

class _AgendaListScreenState extends State<AgendaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // hides default back button use false
        iconTheme: IconThemeData(
          color: Color(0xffe8f4ff), //change your color here
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4, 1.0],
                tileMode: TileMode.clamp,
                colors: [
                  // Color(0xFFe660c3).withOpacity(0.7),
                  Color(0xFF7babdc),
                  Colors.purple.shade300,
                ]),
          ),
          alignment: Alignment.center,
        ),
        title: Text(
          'Notlarım',
          style: TextStyle(
              fontSize: 20.0,
              color: Color(0xffe8f4ff),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0xffe8f4ff),
              size: 25.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddAgendaScreen.routeName,
                  arguments: {'isAdd': null, 'userId': null});
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<Agendas>(context, listen: false).fetchAndSetAgendas(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Agendas>(
                    child: Center(
                      child: const Text('Not henüz yok, ekleyerek başla!'),
                    ),
                    builder: (ctx, agenta, ch) => agenta.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: agenta.items.length,
                            itemBuilder: (ctx, i) =>
                                agenta.items[i].title.isNotEmpty
                                    ? SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            AgendaListItem(
                                                agenta.items[i].userId,
                                                agenta.items[i].title,
                                                agenta.items[i].details,
                                                agenta.items[i].myDate,
                                                agenta.items[i].colorTwo,
                                                agenta.items[i].colorOne),
                                            Divider(),
                                          ],
                                        ),
                                      )
                                    : Text("Error"),
                          ),
                  ),
      ),
      
    );
  }
}
