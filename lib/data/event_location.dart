class EventLocation {
  int? id;
  String? name;
  String? address;
  String? cite;
  String? image;
  List<int>? menus;
  List<int>? event;

  EventLocation(
      {this.id,
      this.name,
      this.address,
      this.cite,
      this.image,
      this.menus,
      this.event});

  EventLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    cite = json['cite'];
    image = json['image'];
    menus = json['menus'].cast<int>();
    event = json['event'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['cite'] = cite;
    data['image'] = image;
    data['menus'] = menus;
    data['event'] = event;
    return data;
  }
}
