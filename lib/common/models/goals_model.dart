import 'dart:convert';

class GoalsModel {
  final String? id;
  final String? metaL;
  final String? dateBegin;
  final String? dateEnd;
  final String? quantidadeMl;
  final List<String>? listHour;

  GoalsModel({
    this.id,
    this.metaL,
    this.dateBegin,
    this.dateEnd,
    this.quantidadeMl,
    this.listHour,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'metaL': metaL,
      'dateBegin': dateBegin,
      'dateEnd': dateEnd,
      'quantidadeMl': quantidadeMl,
      'listHour': listHour,
    };
  }

  factory GoalsModel.fromMap(Map<String, dynamic> map) {
    return GoalsModel(
      id: map['id'] as String?,
      metaL: map['metaL'] as String?,
      dateBegin: map['dateBegin'] as String?,
      dateEnd: map['dateEnd'] as String?,
      quantidadeMl: map['quantidadeMl'] as String?,
      listHour:
          map['listHour'] != null
              ? List<String>.from(map['listHour'] as List)
              : null,
    );
  }
  String toJson() => json.encode(toMap());

  factory GoalsModel.fromJson(String source) =>
      GoalsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
