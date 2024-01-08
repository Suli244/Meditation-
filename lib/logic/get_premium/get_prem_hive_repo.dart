import 'package:hive/hive.dart';
import 'package:meditation/logic/get_premium/prem_hive_model/prem_hive_model.dart';

class GetPremHiveRepo {
  Future<NewPosterModel?> getData() async {
    final box = await Hive.openBox<NewPosterModel>('prem');
    final result = box.get('keyPrem');
    return result;
  }

  setData(NewPosterModel model) async {
    final box = await Hive.openBox<NewPosterModel>('prem');
    box.put('keyPrem', model);
  }
}
