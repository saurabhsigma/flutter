import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/content_models.dart';

final videoRepositoryProvider = Provider((ref) => VideoRepository());

class VideoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'videos';

  Stream<List<VideoModel>> getVideos() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    });
  }

  Future<void> addVideo(VideoModel video) async {
    await _firestore.collection(_collection).doc(video.id).set(_toFirestore(video));
  }

  VideoModel _fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VideoModel(
      id: doc.id,
      title: data['title'] ?? '',
      duration: data['duration'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      description: data['description'] ?? '',
      youtubeId: data['youtubeId'] ?? '',
    );
  }

  Map<String, dynamic> _toFirestore(VideoModel video) {
    return {
      'title': video.title,
      'duration': video.duration,
      'thumbnailUrl': video.thumbnailUrl,
      'description': video.description,
      'youtubeId': video.youtubeId,
    };
  }
}
