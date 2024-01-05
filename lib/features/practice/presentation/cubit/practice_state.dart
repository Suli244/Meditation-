part of 'practice_cubit.dart';

@freezed
class PracticeState with _$PracticeState {
  const factory PracticeState.loading() = _Loading;
  const factory PracticeState.error(String error) = _Error;
  const factory PracticeState.success(List<PracticeModel> model) = _Success;
}
