import 'dart:math';
import '../screens/agenda_detail_screen.dart';
import '../models/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class AgentaItem extends StatelessWidget {
  void selectNot(BuildContext ctx, String userId) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(ctx).pushNamed(
        AgendaDetailScreen.routeName,
        arguments: userId,
      );
    });
  }


  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }
    if (string.isEmpty) {
      return string;
    }
    return string[0].toLowerCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final agenda = Provider.of<Agenda>(context, listen: false);
    String valueString = agenda.colorTwo.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color newColor = new Color(value);
    String valString = agenda.colorOne.split('(0x')[1].split(')')[0]; // kind of hacky..
    int valueOne = int.parse(valString, radix: 16);
    Color myColor = new Color(valueOne);

    return InkWell(
      onTap: () => selectNot(context, agenda.userId),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (agenda.title.toLowerCase().length < 13)
                  ? agenda.title.toLowerCase()
                  : agenda.title.toLowerCase().substring(0, 13),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              agenda.myDate,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              newColor,
              myColor
              //Color(0xFFe660c3).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
