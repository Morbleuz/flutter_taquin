import 'package:flutter/material.dart';

class DialogStat extends StatelessWidget {
  final List<int> mouvements;
  VoidCallback supprimer;

  int _calculMouvement() {
    double moyenne = 0;
    int somme = 0;
    int nombre = 0;
    for (int mouvement in mouvements) {
      somme += mouvement;
      nombre++;
    }
    moyenne = somme / nombre;
    print(moyenne);
    return moyenne.round();
  }

  DialogStat({super.key, required this.mouvements, required this.supprimer});

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
              Padding(padding: EdgeInsets.all(10)),
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
