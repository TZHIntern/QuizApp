class Score {
  final String id;
  final String uid;
  final DateTime time;
  final String category;
  final int categoryIndex;
  final String difficultyLevel;
  final String score;
  final int attempts;
  final int correctAttempts;
  final int wrongAttempts;

  Score(
      {required this.id,
      required this.uid,
      required this.time,
      required this.category,
      required this.categoryIndex,
      required this.difficultyLevel,
      required this.score,
      required this.attempts,
      required this.correctAttempts,
      required this.wrongAttempts});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'time': time.millisecondsSinceEpoch,
      'category': category,
      'categoryIndex': categoryIndex,
      'difficultyLevel': difficultyLevel,
      'score': score,
      'attempts': attempts,
      'correctAttempts': correctAttempts,
      'wrongAttempts': wrongAttempts,
    };
  }
}
