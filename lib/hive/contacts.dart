import 'package:hive/hive.dart';

part 'contacts.g.dart';


@HiveType(typeId: 0)
class Contacts {
  @HiveField(0)
  String name;

  @HiveField(1)
  String imageURL;
  
  @HiveField(2)
  String number;
  
  Contacts({
    this.name,
    this.imageURL,
    this.number,
  });
}
