import 'dart:developer';

import 'package:aquify_app/common/models/analytics_model.dart';
import 'package:aquify_app/services/progress_day_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService implements ProgressDayService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Obtém o UID do usuário autenticado
  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }

  /// Salva um registro no Firestore atrelado ao usuário
  @override
  Future<void> saveProgressDay(AnalyticsModel analytics) async {
    final String? uid = getCurrentUserId();
    if (uid == null) {
      log('Erro: Usuário não autenticado.');
      return;
    }

    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('progressDay')
          .doc(analytics.day) // Cada documento é um dia único
          .set(analytics.toMap(), SetOptions(merge: true));
    } catch (e) {
      log('Erro ao salvar progresso do dia: $e');
    }
  }

  /// Busca todos os registros do usuário autenticado para exibição no gráfico
  @override
  Future<List<AnalyticsModel>> getAllProgressDays() async {
    final String? uid = getCurrentUserId();
    if (uid == null) {
      log('Erro: Usuário não autenticado.');
      return [];
    }

    try {
      final querySnapshot =
          await db.collection('users').doc(uid).collection('progressDay').get();

      return querySnapshot.docs
          .map((doc) => AnalyticsModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log('Erro ao buscar progresso dos dias: $e');
      return [];
    }
  }
}
