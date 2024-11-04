class Devoirs {
  var id;
  String semestre;
  String matiere;
  String date;
  String heure_debut;
  String heure_fin;
  String classe;

  Devoirs(
      {required this.id,
      required this.semestre,
      required this.matiere,
      required this.date,
      required this.heure_debut,
      required this.heure_fin,
      required this.classe,
      });

  factory Devoirs.fromJson(Map<String, dynamic> json) => Devoirs(
        id: json['id'],
        semestre: json['semestre'],
        matiere: json['matiere'],
        date: json['date'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        classe: json['classe'],

      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'semestre': semestre,
        'matiere': matiere,
        'date': date,
        'heure_debut': heure_debut,
        'heure_fin': heure_fin,
        'classe': classe,
      };
}