class HomeModel {
  int? id;
  String? name;

  HomeModel({this.id, this.name});

  factory HomeModel.mapToModel(Map m1) {
    return HomeModel(name: m1['name'], id: m1['id']);
  }
}
