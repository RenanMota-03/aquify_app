import 'package:aquify_app/services/progress_day_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/models/analytics_model.dart';

class FirebaseFirestoreService implements ProgressDayService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Salva os dados de progresso do usuário no Firestore
  @override
  Future<void> saveProgress({
    required String day,
    required String meta,
    required double progress,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Usuário não autenticado.");
      }

      final docRef = _db
          .collection('users')
          .doc(user.uid)
          .collection('progress')
          .doc(day);

      await docRef.set({
        'meta': meta,
        'day': day,
        'progress': progress,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Erro ao salvar progresso: ${e.toString()}");
    }
  }

  /// Busca os dados de progresso do usuário autenticado
  @override
  Future<List<AnalyticsModel>> getAllProgressDays() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Usuário não autenticado.");
      }

      final querySnapshot =
          await _db
              .collection('users')
              .doc(user.uid)
              .collection('progress')
              .orderBy('timestamp', descending: true)
              .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return AnalyticsModel(
          meta: data['meta'],
          day: data['day'],
          progress: data['progress'],
        );
      }).toList();
    } catch (e) {
      throw Exception("Erro ao buscar progresso: ${e.toString()}");
    }
  }
}
