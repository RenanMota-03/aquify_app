class AnalyticsModel {
  final String meta;
  final String day;
  final double progress;

  AnalyticsModel({
    required this.meta,
    required this.day,
    required this.progress,
  });

  /// Converte um mapa para um objeto `AnalyticsModel`
  factory AnalyticsModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsModel(
      meta: map['meta'] as String? ?? '',
      day: map['day'] as String? ?? '',
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Converte um objeto `AnalyticsModel` para um mapa para Firestore
  Map<String, dynamic> toMap() {
    return {"meta": meta, "day": day, "progress": progress};
  }
}
