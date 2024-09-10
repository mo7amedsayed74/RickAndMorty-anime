class Character {
  late int characterId;
  late String name; // The name of the character
  late String image;
  late String gender;
  late String statusIfDeadOrAlive;

  Character.fromJson(Map<String, dynamic> json) {
    characterId = json['id'];
    name = json['name'];
    gender = json['gender'];
    image = json['image'];
    statusIfDeadOrAlive = json['status'];
  }
}
