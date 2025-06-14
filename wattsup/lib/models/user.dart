class User {
  late int identifiant;
  late String nom;
  late String prenom; 
  late String email; 
  late int  numero_tel;
  late String mot_de_passe;
  User({
    required this.identifiant,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.numero_tel,
    required this.mot_de_passe,
  });

}