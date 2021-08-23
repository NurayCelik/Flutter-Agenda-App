import 'dart:math';
import '../models/agenda.dart';
import '../providers/agendas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAgendaScreen extends StatefulWidget {
  static const routeName = '/agenda-screen';
  final bool isAdd;
  final String userId;
  AddAgendaScreen({this.isAdd, this.userId});

  @override
  _AddAgendaScreenState createState() => _AddAgendaScreenState();
}

class _AddAgendaScreenState extends State<AddAgendaScreen> {
  var _isInit = true;
  var _agentaTitle = TextEditingController();
  var _agentaDescription = TextEditingController();
  var _agentaDate = TextEditingController();
  var _initValues = {
    'userId': '',
    'title': '',
    'details': '',
    'myDate': '',
  };
  var _editedAgenda = Agenda(
    userId: '',
    title: '',
    details: '',
    myDate: '',
  );
  DateTime _date = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final int _isEdit = routeArgs['isAdd'];
      final String _editId = routeArgs['userId'];
      print("isEdit:: $_isEdit");
      print("editIDD:: $_editId");
      if (_editId != null && _isEdit == 1) {
        _editedAgenda =
            Provider.of<Agendas>(context, listen: false).findById(_editId);
        setState(() {
          _initValues = {
            'userId': _editedAgenda.userId,
            'title': _editedAgenda.title,
            'details': _editedAgenda.details,
            'myDate': _editedAgenda.myDate,
          };

          _agentaTitle.text = _editedAgenda.title;
          _agentaDescription.text = _editedAgenda.details;
          _agentaDate.text = _editedAgenda.myDate;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _selectAgentaDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      locale: const Locale("tr", "TR"),
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
        builder: (BuildContext context, Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF7babdc),
          accentColor: const Color(0xFF7babdc),
          colorScheme: ColorScheme.light(primary: const Color(0xFF7babdc),),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
          ),
      ),
      child: child,
    );
  },
    );
    DateFormat.E('tr').format(_pickedDate);
    if (_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
        _agentaDate.text = DateFormat('dd-MM-yyyy').format(_pickedDate);
      });
    }
  }

  final List<Color> gridColors = [
    Colors.purple.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.pink.shade200,
  ];

  Color randomGenerator() {
    return gridColors[new Random().nextInt(4)];
  }

  final List<Color> gridColorsOne = [
    //Colors.purple.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
  ];

  Color randomGeneratorOne() {
    return gridColorsOne[new Random().nextInt(2)];
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // hides default back button use false
        iconTheme: IconThemeData(
          color: Color(0xffe8f4ff), //change your color here
        ),
        title: _initValues['userId'] == ''
            ? Text('Not Ekle',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xffe8f4ff),
                    fontWeight: FontWeight.bold))
            : Text(
                'Not Güncelle',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xffe8f4ff),
                    fontWeight: FontWeight.bold),
              ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _agentaTitle,
                //onChanged: (value) => _initValues['title'],
                decoration: InputDecoration(
                  hintText: 'Başlık',
                  //labelText: 'toplantı',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _agentaDate,
                //onChanged: (value) => _initValues['myDate'],
                decoration: InputDecoration(
                  hintText: 'DD-MM-YY',
                  //labelText: 'DD-MM-YY',
                  prefixIcon: InkWell(
                      onTap: () {
                        _selectAgentaDate(context);
                      },
                      child: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF7babdc),
                      )),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _agentaDescription,
                //onChanged: (value) => _initValues['details'],
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Ayrıntılar',
                  //labelText: 'müşteri toplantısı',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: 160.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_initValues['userId'] == '' &&
                        _initValues['title'] == '' &&
                        _initValues['details'] == '' &&
                        _initValues['myDate'] == '') {
                      if (_agentaTitle.text.isEmpty ||
                          _agentaDescription.text.isEmpty ||
                          _agentaDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).errorColor,
                            content: Text(
                              'Lütfen boş alanları doldurunuz!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        );

                        return 'Lütfen boş alanları doldurunuz!';
                      } else {
                        String myColor = randomGenerator().toString();
                        String myColorOne = randomGeneratorOne().toString();
                        print("colors::: $myColor $myColorOne");
                        var agentaObj = Agenda(
                          title: _agentaTitle.text,
                          details: _agentaDescription.text,
                          myDate: _agentaDate.text,
                          colorTwo: myColor,
                          colorOne: myColorOne,
                        );
                        try {
                          await Provider.of<Agendas>(context, listen: false)
                              .addAgenda(agentaObj);
                          print("Agenta : $agentaObj");
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black87,
                              content: Text('Not Eklendi!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).errorColor,
                              content: Text('Not Eklenmedi!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                              duration: Duration(seconds: 5),
                            ),
                          );
                          print(error.toString());
                        }
                        Navigator.of(context).pop();
                      }
                    } else {
                      if (_agentaTitle.text.isEmpty ||
                          _agentaDescription.text.isEmpty ||
                          _agentaDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).errorColor,
                            content: Text(
                              'Lütfen boş alanları doldurunuz!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        );

                        return 'Lütfen boş alanları doldurunuz!';
                      } else {
                        var agentaObj = Agenda(
                          title: _agentaTitle.text,
                          details: _agentaDescription.text,
                          myDate: _agentaDate.text,
                          colorTwo: randomGenerator().toString(),
                          colorOne: randomGeneratorOne().toString(),
                        );
                        try {
                          await Provider.of<Agendas>(context, listen: false)
                              .updateAgenda(agentaObj, _initValues['userId']);
                          print("Agenta : $agentaObj");
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black87,
                              content: Text('Not Güncellendi!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).errorColor,
                              content: Text('Not güncellenmedi!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                              duration: Duration(seconds: 5),
                            ),
                          );
                          print(error.toString());
                        }
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFe660c3).withOpacity(0.7),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  child: _initValues['userId'] == ''
                      ? Text('Kaydet', style: TextStyle(fontSize: 20.0))
                      : Text(
                          'Güncelle',
                          style: TextStyle(fontSize: 20.0),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
