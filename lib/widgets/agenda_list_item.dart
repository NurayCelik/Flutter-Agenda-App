import '../providers/agendas.dart';
import '../screens/add_agenda_screen.dart';
import '../screens/agenda_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class AgendaListItem extends StatelessWidget {
  final String userId;
  final String title;
  final String details;
  final String myDate;
  final String color;
  final String colorOne;

  AgendaListItem(this.userId, this.title, this.details, this.myDate, this.color,
      this.colorOne);

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    String valString =
        color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int valueOne = int.parse(valString, radix: 16);
    Color myColor = new Color(valueOne);
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: myColor,
        child: Text(
          capitalize(title[0]),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(AddAgendaScreen.routeName,
                    arguments: {'isAdd': 1, 'userId': userId});
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).accentColor),
              onPressed: () async {
                try {
                  await Provider.of<Agendas>(context, listen: false)
                      .deleteAgendas(userId);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      title: Text(capitalize(title)),
      subtitle: Text(myDate),
      onTap: () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(
            AgendaDetailScreen.routeName,
            arguments: userId,
          );
        });
      },
    );
  }
}
