class FBResponseModel {
  final String jackson1;
  final String kind2;
  final String under3;
  final String keep4;
  final bool leadGo;
  FBResponseModel({
    required this.jackson1,
    required this.kind2,
    required this.under3,
    required this.keep4,
    required this.leadGo,
  });

  factory FBResponseModel.fromJson(Map<String, dynamic> map) {
    return FBResponseModel(
      jackson1: map['jackson1'] as String,
      kind2: map['kind2'] as String,
      under3: map['under3'] as String,
      keep4: map['keep4'] as String,
      leadGo: map['leadGo'] as bool,
    );
  }

  @override
  String toString() {
    return 'FBResponseModel(jackson1: $jackson1, kind2: $kind2, under3: $under3, keep4: $keep4, leadGo: $leadGo)';
  }
}
