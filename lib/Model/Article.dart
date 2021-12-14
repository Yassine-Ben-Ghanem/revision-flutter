// ignore: file_names
// ignore_for_file: unnecessary_this

class Article {
  int _code = 0;
  String _lib = "";
  double _qte = 0.0;
  Article(this._code, this._lib, this._qte);

  double get qte => _qte;
  set qte(double qte) {
    _qte = qte;
  }

  set lib(String lib) {
    _lib = lib;
  }

  set code(int code) {
    _code = code;
  }

  String get lib => _lib;
  int get code => _code;
  @override
  String toString() {
    // TODO: implement toString
    return "Article{code=$code,quantite=$qte, libelle=$lib}";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "codearticle": _code,
      "libelle": _lib,
      "qte": _qte
    };
    return map;
  }

  factory Article.fromMap(Map<String, dynamic> json) =>
      new Article(json['codearticle'], json["libelle"], json['qte']);
}
