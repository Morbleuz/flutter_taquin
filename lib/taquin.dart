import 'dart:math';

class Taquin {
  List<int> _taquin = new List.generate(9, (index) => 0);
  int _nombreDeCoups = 0;

  Taquin();
  //Constructeur pour créer un taquin fiable
  Taquin.create() {
    for (int x = 0; x < _taquin.length - 1; x++) {
      //Nombre random entre 1 et 8
      int random = Random().nextInt(8) + 1;
      while (this._taquin.contains(random)) {
        random = Random().nextInt(8) + 1;
      }
      this._taquin[x] = random;
    }
  }
  void _incrementNombreDeCoups() {
    this._nombreDeCoups++;
  }

  void setTaquin(List<int> taquin) {
    this._taquin = taquin;
  }

  int getNombreDeCoups() {
    return this._nombreDeCoups;
  }

  List<int> getTaquin() {
    return this._taquin;
  }

  bool _caseEgalZero(int index) {
    bool caseEgalZero = false;
    if (this._taquin[index] == 0) {
      caseEgalZero = true;
    }
    return caseEgalZero;
  }

  bool _estACoteDeZero(int index) {
    bool aCote = false;
    //On vérifie qu'il est différent de 0
    if (!_caseEgalZero(index)) {
      //On check toutes les possibilités des 0 possible à côté
      if (index == 0) {
        if (this._taquin[1] == 0 || this._taquin[3] == 0) {
          aCote = true;
        }
      } else if (index == 1) {
        if (this._taquin[0] == 0 ||
            this._taquin[2] == 0 ||
            this._taquin[4] == 0) {
          aCote = true;
        }
      } else if (index == 2) {
        if (this._taquin[1] == 0 || this._taquin[5] == 0) {
          aCote = true;
        }
      } else if (index == 3) {
        if (this._taquin[0] == 0 ||
            this._taquin[4] == 0 ||
            this._taquin[6] == 0) {
          aCote = true;
        }
      } else if (index == 4) {
        if (this._taquin[1] == 0 ||
            this._taquin[3] == 0 ||
            this._taquin[5] == 0 ||
            this._taquin[7] == 0) {
          aCote = true;
        }
      } else if (index == 5) {
        if (this._taquin[2] == 0 ||
            this._taquin[4] == 0 ||
            this._taquin[8] == 0) {
          aCote = true;
        }
      } else if (index == 6) {
        if (this._taquin[3] == 0 || this._taquin[7] == 0) {
          aCote = true;
        }
      } else if (index == 7) {
        if (this._taquin[4] == 0 ||
            this._taquin[6] == 0 ||
            this._taquin[8] == 0) {
          aCote = true;
        }
      } else {
        if (this._taquin[5] == 0 || this._taquin[7] == 0) {
          aCote = true;
        }
      }
    }
    return aCote;
  }

  void testFini() {
    this._taquin = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  }

  void changeCase(int index) {
    if (_estACoteDeZero(index) && !estFini()) {
      int nombre = this._taquin[index];
      print("index = " + index.toString());
      //On stocke le numéro à l'index définie
      int nombreReset = 0;
      //On stocke le nombre reset qui est de 0
      int indexZero = 0;
      for (int x = 0; x < this._taquin.length; x++) {
        if (this._taquin[x] == 0) {
          indexZero = x;
          print(this._taquin);
        }
      }
      print("index de zéro = " + indexZero.toString());
      print("nombre = " + nombre.toString());
      this._taquin[index] = nombreReset;
      this._taquin[indexZero] = nombre;
      _incrementNombreDeCoups();
    }
  }

  bool estFini() {
    bool fini = false;
    if (this._taquin[0] == 1 &&
        this._taquin[1] == 2 &&
        this._taquin[2] == 3 &&
        this._taquin[3] == 4 &&
        this._taquin[4] == 5 &&
        this._taquin[5] == 6 &&
        this._taquin[6] == 7 &&
        this._taquin[7] == 8 &&
        this._taquin[8] == 0) {
      fini = true;
    }
    return fini;
  }
}