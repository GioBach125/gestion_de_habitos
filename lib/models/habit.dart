class Habit {
  int? id;
  String name;
  List<bool> daysCompleted;
  int profileId;

  Habit(
      {this.id,
      required this.name,
      required this.daysCompleted,
      required this.profileId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'daysCompleted': daysCompleted.map((e) => e.toString()).join(','),
      'profileId': profileId,
    };
  }

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      daysCompleted: (map['daysCompleted'] as String)
          .split(',')
          .map((e) => e == 'true')
          .toList(),
      profileId: map['profileId'],
    );
  }
}
