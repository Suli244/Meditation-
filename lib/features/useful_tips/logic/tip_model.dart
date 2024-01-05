class TipsModel {
  final String title;
  final String description;
  final String image;
  final bool premium;

  TipsModel({
    required this.title,
    required this.image,
    required this.description,
    required this.premium,
  });

  factory TipsModel.fromJson(Map<String, dynamic> map, bool isPremium) {
    return TipsModel(
      title: map['title'],
      description: map['description'],
      image: map['image'],
      premium: isPremium,
    );
  }
}
