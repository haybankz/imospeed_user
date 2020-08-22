class AreaCity {
  final int areaId;
  final String createdAt;
  final int id;
  final String name;
  final int show;
  final int stateId;
  final String updatedAt;

  AreaCity({this.areaId, this.createdAt, this.id, this.name, this.show, this.stateId, this.updatedAt});

  factory AreaCity.fromJson(Map<String, dynamic> json) {
    return AreaCity(
      areaId: json['area_id'],
      createdAt: json['created_at'],
      id: json['id'],
      name: json['name'],
      show: json['show'],
      stateId: json['state_id'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['show'] = this.show;
    data['state_id'] = this.stateId;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}