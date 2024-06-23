class Profile {
  int? id;
  String name;

  Profile({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
    );
  }
}
