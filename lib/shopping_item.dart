import 'package:floor/floor.dart';

@entity
class ShoppingItem {
  @primaryKey
  final int? id;

  final String name;
  final String quantity;
  ShoppingItem({this.id, required this.name , required this.quantity});
}