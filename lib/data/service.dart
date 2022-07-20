class Service {
  int? id;
  String? name;
  String? type;
  int? price;
  String? image;
  Null? video;
  String? description;
  int? event;
  bool?isSelected;

  Service(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.image,
      this.video,
      this.description,
      this.event,
      this.isSelected = false,
      });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    video = json['video'];
    description = json['description'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['image'] = this.image;
    data['video'] = this.video;
    data['description'] = this.description;
    data['event'] = this.event;
    return data;
  }
}
