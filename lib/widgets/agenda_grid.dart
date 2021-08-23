import '../providers/agendas.dart';
import './agenda_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final agendaData = Provider.of<Agendas>(context);
    agendaData.fetchAndSetAgendas();
    final agenta = agendaData.items;
    return GridView.builder(
      // reverse: true,//sonuncuyu ilk gösterir
      padding: const EdgeInsets.all(10.0),
      itemCount: agenta.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: agenta[i],
        child: AgentaItem(),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
