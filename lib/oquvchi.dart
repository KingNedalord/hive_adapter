import 'package:hive_flutter/adapters.dart';

part 'oquvchi.g.dart';
@HiveType(typeId: 0)
class Oquvchi{
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String ocupation;

  Oquvchi({required this.name,required this.age,required this.ocupation});
}