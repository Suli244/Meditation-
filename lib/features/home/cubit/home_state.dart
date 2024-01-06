part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded(List<HomeModel> data) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
