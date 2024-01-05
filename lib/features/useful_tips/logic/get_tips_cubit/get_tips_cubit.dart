import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meditation/features/useful_tips/logic/tip_model.dart';

part 'get_tips_cubit.freezed.dart';
part 'get_tips_state.dart';

class GetTipsCubit extends Cubit<GetTipsState> {
  GetTipsCubit() : super(const GetTipsState.loading()) {
    getTips();
  }

  final dio = Dio();

  final List<TipsModel> savedList = [];

  getTips() async {
    emit(const GetTipsState.loading());
    try {
      final result = await dio.get(
          'https://meditation-258-default-rtdb.firebaseio.com/tips.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');
      final listModel = result.data
          .map<TipsModel>(
            (e) => TipsModel.fromJson(e, result.data.indexOf(e) > 7),
          )
          .toList();
      savedList.addAll(listModel);
      emit(GetTipsState.success(listModel));
    } catch (e) {
      emit(GetTipsState.error(e.toString()));
    }
  }

  searchList(String text) {
    emit(const GetTipsState.loading());
    try {
      List<TipsModel> newList = List<TipsModel>.from(savedList);

      newList.removeWhere(
          (e) => !e.title.toLowerCase().contains(text.toLowerCase()));

      emit(GetTipsState.success(newList));
    } catch (e) {
      emit(GetTipsState.error(e.toString()));
    }
  }
}
