class State {
  final String createdAt;
  final int id;
  final String name;
  final int region;
  final int showState;
  final String updatedAt;

  State({this.createdAt, this.id, this.name, this.region, this.showState, this.updatedAt});

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      createdAt: json['created_at'],
      id: json['id'],
      name: json['name'],
      region: json['region'],
      showState: json['show_state'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['region'] = this.region;
    data['show_state'] = this.showState;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}