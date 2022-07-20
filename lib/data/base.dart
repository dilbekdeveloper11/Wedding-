class Base {
  int? id;
  String? image;
  String? title;

  Base({this.id, this.image, this.title});

  Base.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
