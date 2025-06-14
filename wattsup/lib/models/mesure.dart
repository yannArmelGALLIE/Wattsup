class Mesure {
  late double tension;
  late double courant;
  late double puissance;
  late DateTime timestamp;
  late int compteur;

  Mesure({
    required this.tension,
    required this.courant,
    required this.puissance,
    required this.timestamp,
    required this.compteur
  });
}