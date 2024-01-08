import 'package:hive/hive.dart';

part 'prem_hive_model.g.dart';

@HiveType(typeId: 0)
class NewPosterModel extends HiveObject {
  @HiveField(0)
  String secondUrl;

  @HiveField(1)
  bool isOpen;
  NewPosterModel({
    required this.secondUrl,
    required this.isOpen,
  });
}
