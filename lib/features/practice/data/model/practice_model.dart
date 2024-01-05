class PracticeModel {
  final String time;
  final String title;
  final String image;
  final String audioLink;
  final bool premium;

  PracticeModel({
    required this.time,
    required this.image,
    required this.title,
    required this.audioLink,
    required this.premium,
  });

  factory PracticeModel.fromJson(Map<String, dynamic> map, bool isPremium) {
    return PracticeModel(
      time: map['time'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      audioLink: map['audioLink'] ?? '',
      premium: isPremium,
    );
  }
}
