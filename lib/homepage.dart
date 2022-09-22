import 'package:flutter/material.dart';
import 'package:flutter_taquin/alertdialogue.dart';
import 'package:flutter_taquin/taquin.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Taquin _taquin = Taquin.create();
  Color couleur = Colors.indigo;
  int _seconds = 0;
  bool _chronoLancer = false;
  final _db = Hive.box('taquin');

  void _envoyerMouvements(int mouvements) {
    if (_db.get(0) == null) {
      List<int> listMouvement = [mouvements];
      _db.put(0, listMouvement);
    } else {
      List<int> listMouvements = _db.get(0);
      listMouvements.add(mouvements);
      _db.put(0, listMouvements);
    }
  }

  List<int> _lireMouvements() {
    List<int> mouvements = [0];
    if (_db.get(0) != null) {
      mouvements = _db.get(0);
    }
    print(mouvements);
    return mouvements;
  }

  void _supprimerMouvements() {
    _db.delete(0);
    _lireMouvements();
  }

  void _chrono() async {
    while (_chronoLancer) {
      _chronoLancer = true;
      await Future.delayed(Duration(seconds: 1));
      if (!_taquin.estFini()) {
        _seconds++;
      }
      setState(() {});
    }
  }

  void _stopLeChrono() {
    _chronoLancer = false;
    setState(() {});
  }

  void _lancerLeChrono() {
    if (!_chronoLancer) {
      _chronoLancer = true;
      _chrono();
    }

    setState(() {});
  }

  void _changeCase(index) {
    setState(() {
      _taquin.changeCase(index);
      if (_taquin.estFini()) {
        print("Envoie des mouvements");
        _envoyerMouvements(_taquin.getNombreDeCoups());
        _stopLeChrono();
      }
      if (_taquin.getNombreDeCoups() >= 1) {
        _lancerLeChrono();
      }
    });
  }

  void _nouvellePartie() {
    setState(() {
      _chronoLancer = false;
      _seconds = 0;
      _taquin = Taquin.create();
    });
  }

  Color _choiceCouleur(int index) {
    setState(() {
      if (_taquin.getTaquin()[index] == 0) {
        couleur = Colors.indigoAccent;
      } else {
        couleur = Colors.indigo;
      }
    });
    return couleur;
  }

  String _sendTextTaquin(int index) {
    String text = "";
    setState(() {
      if (_taquin.getTaquin()[index] != 0) {
        text = _taquin.getTaquin()[index].toString();
      }
    });
    return text;
  }

  void _showStat(context) {
    showDialog(
        context: context,
        builder: (context) => DialogStat(
            mouvements: _lireMouvements(), supprimer: _supprimerMouvements));
  }

  void _testFini() {
    setState(() {
      _changeCase(0);
      _taquin.testFini();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Taquin",
          ),
          actions: [
            TextButton(
                onPressed: _nouvellePartie,
                child: const Text(
                  "Nouvelle partie",
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
                onPressed: _testFini,
                child: const Text(
                  "Test fini",
                  style: TextStyle(color: Colors.white),
                )),
            IconButton(
                onPressed: () => _showStat(context),
                icon: const Icon(Icons.display_settings)),
          ],
        ),
        body: Column(children: [
          if (_taquin.estFini())
            Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Text(
                    "Bravo ! Vous avez gagné en ${_taquin.getNombreDeCoups()} mouvements."),
                Text(
                  "Et en $_seconds secondes.",
                ),
                const Text(
                    "N'hésitez pas à relancer une partie, c'est gratuit"),
              ],
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "Mouvements : ${_taquin.getNombreDeCoups().toString()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "$_seconds",
                    style: const TextStyle(fontSize: 40, fontFamily: 'Alarm'),
                  ),
                ),
              ],
            ),
          Expanded(
              child: GridView(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            children: List.generate(_taquin.getTaquin().length, (index) {
              return Container(
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _choiceCouleur(index),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                        onPressed: (() => _changeCase(index)),
                        child: Text(
                          (_sendTextTaquin(index)),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        )),
                  ));
            }),
          ))
        ]));
  }
}
