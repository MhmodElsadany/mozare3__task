class TrailersModel {
  String? id;
  String? iso_639_1;
  String? iso_3166_1;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  TrailersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso_639_1 = json['iso_639_1'];
    iso_3166_1 = json['iso_3166_1'];
    key = json['key'];

    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso_639_1;
    data['iso_3166_1'] = this.iso_3166_1;
    data['name'] = this.name;

    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;

    return data;
  }
}
