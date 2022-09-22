//Class qui vas nous permmette de init, update, getData
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TaquinDataBase {
  @HiveField(0)
  List<int> mouvements;

  TaquinDataBase(this.mouvements);
}
