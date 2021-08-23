import 'package:flutter/foundation.dart';
import '../models/agenda.dart';
import '../helpers/db_helper.dart';

class Agendas with ChangeNotifier {
  var isLoading = false;
  List<Agenda> _items = [];

  List<Agenda> get items {
    return [..._items];
  }

  Agenda findById(String id) {
    return _items.firstWhere((agenda) => agenda.userId == id);
  }

  Future<void> addAgenda(Agenda myAgenta) async {
    isLoading = true;
    final newAgenda = Agenda(
      userId: DateTime.now().toString(),
      title: myAgenta.title,
      details: myAgenta.details,
      myDate: myAgenta.myDate,
      colorTwo: myAgenta.colorTwo,
      colorOne: myAgenta.colorOne,
    );
    _items.add(newAgenda);
    notifyListeners();
    DBHelper.insert('table', {
      'userId': newAgenda.userId,
      'title': newAgenda.title,
      'details': newAgenda.details,
      'myDate': newAgenda.myDate,
      'colorTwo': newAgenda.colorTwo,
      'colorOne': newAgenda.colorOne,
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAndSetAgendas() async {
    isLoading = true;
    final dataList = await DBHelper.getData('table');
    _items = dataList
        .map(
          (item) => Agenda(
            userId: item['userId'],
            title: item['title'],
            details: item['details'],
            myDate: item['myDate'],
            colorTwo: item['colorTwo'],
            colorOne: item['colorOne'],
          ),
        )
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteAgendas(String userId) async {
    isLoading = true;
    await DBHelper.deleteData('table', userId);
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTable(String table) async {
    isLoading = true;
    await DBHelper.deleteDatabase(table);
    //print("deleted");
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateAgenda(Agenda myAgenta, String userId) async {
    isLoading = true;
    final newAgenda = Agenda(
      userId: DateTime.now().toString(),
      title: myAgenta.title,
      details: myAgenta.details,
      myDate: myAgenta.myDate,
      colorTwo: myAgenta.colorTwo,
      colorOne: myAgenta.colorOne,

    );
    _items.add(newAgenda);
    notifyListeners();
    DBHelper.updateData(
        'table',
        {
          'userId': newAgenda.userId,
          'title': newAgenda.title,
          'details': newAgenda.details,
          'myDate': newAgenda.myDate,
          'colorTwo': newAgenda.colorTwo,
          'colorOne': newAgenda.colorOne,
        },
        userId);

    isLoading = false;
    notifyListeners();
  }
}
