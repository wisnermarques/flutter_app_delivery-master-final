class CategoriesModel {
  int id;
  String name;
  String img;
  int total;

  CategoriesModel(this.id, this.name, this.img, this.total);

  factory CategoriesModel.fromJson(dynamic json) {
    return CategoriesModel(
      json['id'] as int,
      json['attributes']['categoria'] as String,
      json['attributes']['img']['data']['attributes']['formats']['thumbnail']
          ['url'] as String,
      json['attributes']['total'] as int,
    );
  }
}
