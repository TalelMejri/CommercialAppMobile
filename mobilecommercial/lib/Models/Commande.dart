class Commande {
  int id;
  String type;
  String qte;
  int idcl;
  String status;

  Commande(
      {required this.id,
      required this.type,
      required this.qte,
      required this.idcl,
      required this.status,
      r});

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
        id: json['id'],
        type: json['type'],
        qte: json['qte'],
        idcl: json['IdClient'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'qte': qte,
      'status': status,
      'IdClient': idcl,
    };
  }

  @override
  String toString() {
    return type + "" + qte.toString() + "" + status + "" + idcl.toString() + "" + id.toString();
  }
}
