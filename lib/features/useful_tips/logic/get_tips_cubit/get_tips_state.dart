part of 'get_tips_cubit.dart';

@freezed
class GetTipsState with _$GetTipsState {
  const factory GetTipsState.loading() = _Loading;
  const factory GetTipsState.error(String error) = _Error;
  const factory GetTipsState.success(List<TipsModel> model) = _Success;
}
