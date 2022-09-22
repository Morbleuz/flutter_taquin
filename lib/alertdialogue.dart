import 'package:flutter/material.dart';

class DialogStat extends StatelessWidget {
  final List<int> mouvements;

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

  DialogStat({super.key, required this.mouvements});

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
                  'Vôtre pourcentage de mouvements est de ${_calculMouvement()}'),
              MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.indigo,
                  child: const Text('Retour'))
            ],
          ),
        ));
  }
}
