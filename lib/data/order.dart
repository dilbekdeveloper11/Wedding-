class Order {
  int? totalPrice;
  int? peopleCount;
  int? menu;
  int? user;
  int? weddingHall;
  List<int>? service;
  String? status;

  Order(
      {this.totalPrice,
      this.peopleCount,
      this.menu,
      this.user,
      this.weddingHall,
      this.service,
      this.status});

  Order.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    peopleCount = json['people_count'];
    menu = json['menu'];
    user = json['user'];
    weddingHall = json['wedding_hall'];
    service = json['service'].cast<int>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_price'] = totalPrice;
    data['people_count'] = peopleCount;
    data['menu'] = menu;
    data['user'] = user;
    data['wedding_hall'] = weddingHall;
    data['service'] = service;
    data['status'] = status;
    return data;
  }
}
