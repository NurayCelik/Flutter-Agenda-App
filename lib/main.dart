import './screens/agenda_detail_screen.dart';
import './screens/home_screen.dart';
import './screens/add_agenda_screen.dart';
import './providers/agendas.dart';
import './screens/agenda_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //appbarın üzerindeki kısa alanı yok eder flutter_statusbarcolor paketini kullanarak
    FlutterStatusbarcolor.setStatusBarColor(
        Colors.transparent); //Color(0xFF7babdc));
    return ChangeNotifierProvider.value(
      value: Agendas(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ajanda App',
          localizationsDelegates: [GlobalMaterialLocalizations.delegate],
          supportedLocales: [const Locale('en'), const Locale('tr')],
          theme: ThemeData(
            primaryColor: Color(0xFF7babdc),
            accentColor: Colors.pink.shade300,
            fontFamily: 'Quicksand',
            canvasColor: Color(0xffffffff), //sayfa rengi
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  color: Colors.black87,
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quicksand-bold',
                  fontWeight: FontWeight.w400,
                )),

            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Color(0xFFe660c3).withOpacity(0.7),
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          home: HomeScreen(),
          routes: {
            AddAgendaScreen.routeName: (ctx) => AddAgendaScreen(),
            AgendaListScreen.routeName: (ctx) => AgendaListScreen(),
            AgendaDetailScreen.routeName: (ctx) => AgendaDetailScreen(),
          }),
    );
  }
}
