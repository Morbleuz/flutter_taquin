import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taquin/taquin.dart';
import 'package:flutter/src/rendering/box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Taquin _taquin = Taquin.create();
  Color couleur = Colors.indigo;
  void _changeCase(index) {
    setState(() {
      _taquin.changeCase(index);
    });
  }

  void _nouvellePartie() {
    setState(() {
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

  void _fini() {
    setState(() {
      _taquin.testFini();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Taquin"),
          actions: [
            TextButton(
                onPressed: _nouvellePartie,
                child: const Text(
                  "Nouvelle partie",
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
                onPressed: _fini,
                child: const Text(
                  "Test fini",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: Column(children: [
          if (_taquin.estFini()) Padding(padding: EdgeInsets.all(10)),
          if (_taquin.estFini())
            Text("Bravo ! Vous avez gagné en " +
                _taquin.getNombreDeCoups().toString() +
                " mouvements"),
          if (_taquin.estFini())
            const Text("N'hésitez pas à relancer une partie, c'est gratuit"),
          if (!_taquin.estFini())
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Mouvements : " + _taquin.getNombreDeCoups().toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                )
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
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: (() => _changeCase(index)),
                      child: Text(
                        (_sendTextTaquin(index)),
                        style: TextStyle(color: Colors.white),
                      )));
            }),
          ))
        ]));
  }
}
