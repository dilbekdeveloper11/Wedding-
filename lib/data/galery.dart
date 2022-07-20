class Galery {
  int? id;
  String? name;
  String? type;
  String? description;
  List<Images>? images;

  Galery({this.id, this.name, this.type, this.description, this.images});

  Galery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? image;
  int? systemInfo;

  Images({this.id, this.image, this.systemInfo});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    systemInfo = json['system_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['system_info'] = systemInfo;
    return data;
  }
}
