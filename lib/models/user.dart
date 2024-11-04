class User {
  int id_user;
  String nom;
  String prenom;
  String email;
  String telephone;
  String password;
  String status;

  User(this.id_user, this.nom, this.prenom, this.email, this.telephone,
      this.password,this.status);

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json['id_user']),
        json['nom'],
        json['prenom'],
        json['email'],
        json['telephone'],
        json['password'],
      json["status"],
      );

  Map<String, dynamic> toJson() => {
        'id_user': id_user.toString(),
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'telephone': telephone,
        'password': password,
        'status': status
      };
}
