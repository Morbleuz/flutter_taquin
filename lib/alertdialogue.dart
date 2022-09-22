import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DialogStat extends StatelessWidget {
  var mouvements;
  final _db = Hive.box('taquin');

  int _calculMouvement() {
    double moyenne = 0;
    mouvements = _db.get(0);

    if (mouvements != null) {
      int somme = 0;
      int nombre = 0;
      for (int mouvement in mouvements) {
        somme += mouvement;
        nombre++;
      }
      moyenne = somme / nombre;
    }
    return moyenne.round();
  }

  void supprimer() {
    this.mouvements = [0];
    _db.put(0, this.mouvements);
    _calculMouvement();
  }

  DialogStat({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vôtre moyenne de mouvements est ${_calculMouvement()}',
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      onPressed: () => supprimer,
                      color: Colors.indigo,
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      )),
                  MaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: Colors.indigo,
                      child: const Text('Retour',
                          style: TextStyle(color: Colors.white)))
                ],
              )
            ],
          ),
        ));
  }
}
