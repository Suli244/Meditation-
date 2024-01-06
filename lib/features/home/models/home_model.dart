class HomeModel {
  List<String>? descriptions;
  String? image;
  int? time;
  String? title;
  bool? isLike;
  bool? premium;

  HomeModel(
      {this.descriptions,
      this.image,
      this.time,
      this.title,
      this.isLike,
      this.premium});

  HomeModel.fromJson(Map<String, dynamic> json, bool isPremium) {
    descriptions = json['descriptions'].cast<String>();
    image = json['image'];
    time = json['time'];
    title = json['title'];
    premium = isPremium;
    isLike = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descriptions'] = descriptions;
    data['image'] = image;
    data['time'] = time;
    data['title'] = title;
    return data;
  }
}
