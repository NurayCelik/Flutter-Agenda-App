import '../providers/agendas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaDetailScreen extends StatelessWidget {
  static const routeName = '/agenda-detail';

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
    final notId = ModalRoute.of(context).settings.arguments as String;
    final loadedAgenda = Provider.of<Agendas>(
      context,
      listen: false,
    ).findById(notId);
    return Scaffold(
      /*  appBar: AppBar(
        title: Text(loadedProduct.title),
      ), */
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 70.0,
          iconTheme: IconThemeData(
            color: Color(0xffe8f4ff),
          ),
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Not Detay',
                style: TextStyle(
                  color: Color(0xffe8f4ff),
                ),
              ),
            ),
            background: Hero(
              tag: loadedAgenda.userId,
              child: Container(
                height: 70.0,
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
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 30.0,
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 30),
              Text(
                '${capitalize(loadedAgenda.title)}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${loadedAgenda.myDate}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '${capitalize(loadedAgenda.details)}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 800,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
