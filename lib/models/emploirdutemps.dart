class Emploidutemps {
  int id;
  String semestre;
  String classe;
  String matiere;
  String jour;
  String prof;
  String heure_debut;
  String heure_fin;


  Emploidutemps(
      {required this.id,
      required this.semestre,
      required this.classe,
      required this.matiere,
      required this.jour,
      required this.prof,
      required this.heure_debut,
      required this.heure_fin,
      });

  factory Emploidutemps.fromJson(Map<String, dynamic> json) => Emploidutemps(
        id: int.parse(json['id']),
        semestre: json['semestre'],
        classe: json['classe'],
        matiere: json['matiere'],
        jour: json['jour'],
        prof: json['prof'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'semestre': semestre,
        'classe': classe,
        'matiere': matiere,
        'jour': jour,
        'prof': prof,
        'heure_debut': heure_debut,
        'heure_fin': heure_fin,
      };
}