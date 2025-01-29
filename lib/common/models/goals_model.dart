import 'dart:convert';

class GoalsModel {
  final String? id;
  final String? metaL;
  final String? dateBegin;
  final String? dateEnd;
  final String? quantidadeMl;

  GoalsModel({
    this.id,
    this.metaL,
    this.dateBegin,
    this.dateEnd,
    this.quantidadeMl,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'metaL': metaL,
      'dateBegin': dateBegin,
      'dateEnd': dateEnd,
      'quantidadeMl': quantidadeMl,
    };
  }

  factory GoalsModel.fromMap(Map<String, dynamic> map) {
    return GoalsModel(
      id: map['id'] != null ? map['id'] as String : null,
      metaL: map['metaL'] != null ? map['metaL'] as String : null,
      dateBegin: map['dateBegin'] != null ? map['dateBegin'] as String : null,
      dateEnd: map['dateEnd'] != null ? map['dateEnd'] as String : null,
      quantidadeMl:
          map['quantidadeMl'] != null ? map['quantidadeMl'] as String : null,
    );
  }
  String toJson() => json.encode(toMap());
  factory GoalsModel.fromJson(String source) =>
      GoalsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
