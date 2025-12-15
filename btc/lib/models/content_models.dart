class VideoModel {
  final String id;
  final String title;
  final String duration;
  final String thumbnailUrl;
  final String description;
  final String youtubeId;

  const VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    required this.description,
    required this.youtubeId,
  });
}

class MaterialModel {
  final String id;
  final String title;
  final String subject;
  final String description;

  const MaterialModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
  });
}
