import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        "title": "Combo KO Rookie",
        "desc": "LVL 1 + papas + bebida",
        "price": 119,
        "tag": "Recomendado nuevos"
      },
      {
        "title": "Combo Guerrero",
        "desc": "LVL 2 + papas grandes",
        "price": 159,
        "tag": "Más vendido"
      },
      {
        "title": "Combo Campeón KO",
        "desc": "LVL 3 + papas + postre",
        "price": 199,
        "tag": "Modo brutal"
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Ofertas KO")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        itemBuilder: (_, i) {
          final o = offers[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(o["title"] as String),
              subtitle: Text("${o["desc"]} · ${o["tag"]}"),
              trailing: Text(
                "\$${o["price"]}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
