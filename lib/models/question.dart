class TimelineStage {
  final String label; // misal "1 Detik", "1 Tahun"
  final String description;

  const TimelineStage({required this.label, required this.description});
}

class Question {
  final String _id;
  final String _title;
  final String _category;
  final String _imagePath;
  final String _shortAnswer;
  final Map<String, String> _dimensions; // "Biology" -> penjelasan, dst
  final List<TimelineStage> _timeline;
  final List<String> _relatedQuestionIds;
  bool _isExplored;
  bool _isSaved;

  Question({
    required String id,
    required String title,
    required String category,
    required String imagePath,
    required String shortAnswer,
    required Map<String, String> dimensions,
    required List<TimelineStage> timeline,
    required List<String> relatedQuestionIds,
    bool isExplored = false,
    bool isSaved = false,
  })  : _id = id,
        _title = title,
        _category = category,
        _imagePath = imagePath,
        _shortAnswer = shortAnswer,
        _dimensions = dimensions,
        _timeline = timeline,
        _relatedQuestionIds = relatedQuestionIds,
        _isExplored = isExplored,
        _isSaved = isSaved;

  // GETTER
  String get id => _id;
  String get title => _title;
  String get category => _category;
  String get imagePath => _imagePath;
  String get shortAnswer => _shortAnswer;
  Map<String, String> get dimensions => _dimensions;
  List<TimelineStage> get timeline => _timeline;
  List<String> get relatedQuestionIds => _relatedQuestionIds;
  bool get isExplored => _isExplored;
  bool get isSaved => _isSaved;

  // SETTER
  set isExplored(bool value) {
    _isExplored = value;
  }

  set isSaved(bool value) {
    _isSaved = value;
  }

  bool matchesKeyword(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    return title.toLowerCase().contains(lowerKeyword) ||
        category.toLowerCase().contains(lowerKeyword);
  }
}

const Map<String, String> categoryIcons = {
  'Earth': '🌍',
  'Human': '🧬',
  'Space': '🚀',
  'Technology': '🤖',
  'Mind': '🧠',
};