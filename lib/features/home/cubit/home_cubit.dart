import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meditation/features/home/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.loading());

  final dio = Dio();

  final List<HomeModel> savedList = [];

  getData(String json) async {
    emit(const HomeState.loading());
    try {
      final result = await dio.get(
          'https://meditation-258-default-rtdb.firebaseio.com/$json.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');
      final listModel = result.data
          .map<HomeModel>(
            (e) => HomeModel.fromJson(e, result.data.indexOf(e) > 4),
          )
          .toList();

      savedList.addAll(listModel);
      emit(HomeState.loaded(listModel));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }
}
