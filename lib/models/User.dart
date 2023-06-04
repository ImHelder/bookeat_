class UserCustom {
  // identifiant
  final String id;
  // Nom de l'utilsiateur
  final String nom;
  // Prenom de l'utilisateur
  final String prenom;
  // Date de naissance
  final String dateNaissance;
  // Email
  final String email;
  // Numero de telephone
  final String phone;
  // Mot de passe
  final String password;
  // Liste des favoris
  final List<String> favoris;

  /// sexe
  final String sexe;

  /// indique s'il est administrateur ou non
  final String userType;

  const UserCustom(
    this.favoris,
    this.sexe,
    this.userType,
    this.dateNaissance, {
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phone,
    required this.password,
  });
}
