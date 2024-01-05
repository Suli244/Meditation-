import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';

part 'practice_cubit.freezed.dart';
part 'practice_state.dart';

class PracticeCubit extends Cubit<PracticeState> {
  PracticeCubit() : super(const PracticeState.loading()) {
    getPractice();
  }
  final dio = Dio();

  final List<PracticeModel> savedList = [];

  getPractice() async {
    emit(const PracticeState.loading());
    try {
      final result = await dio.get(
          'https://meditation-258-default-rtdb.firebaseio.com/music.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');
      final listModel = result.data
          .map<PracticeModel>(
            (e) => PracticeModel.fromJson(e, result.data.indexOf(e) > 7),
          )
          .toList();
      savedList.addAll(listModel);
      emit(PracticeState.success(listModel));
    } catch (e) {
      emit(PracticeState.error(e.toString()));
    }
  }

  searchList(String text) {
    emit(const PracticeState.loading());
    try {
      List<PracticeModel> newList = List<PracticeModel>.from(savedList);
      newList.removeWhere(
          (e) => !e.title.toLowerCase().contains(text.toLowerCase()));
      emit(PracticeState.success(newList));
    } catch (e) {
      emit(PracticeState.error(e.toString()));
    }
  }
}
