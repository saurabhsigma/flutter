import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/content_models.dart';

final materialRepositoryProvider = Provider((ref) => MaterialRepository());

class MaterialRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'materials';

  Stream<List<MaterialModel>> getMaterials() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    });
  }

  Future<void> addMaterial(MaterialModel material) async {
    await _firestore.collection(_collection).doc(material.id).set(_toFirestore(material));
  }

  MaterialModel _fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MaterialModel(
      id: doc.id,
      title: data['title'] ?? '',
      subject: data['subject'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> _toFirestore(MaterialModel material) {
    return {
      'title': material.title,
      'subject': material.subject,
      'description': material.description,
    };
  }
}
