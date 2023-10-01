import 'package:quiz_app/data/model/questions.dart';

class PrepareQuizs {
  List<Question> questions = [];

  String getQuestion(int i) {
    return questions[i].question;
  }

  List<String> options(int i) {
    return questions[i].options;
  }

  bool isCorrect(int i, int selectedoption) {
    if (questions[i].options[selectedoption] == questions[i].answer) {
      return true;
    } else {
      return false;
    }
  }

  List<String> _createOptions(dynamic json, int i) {
    List<String> list = (json[i]['incorrectAnswers']).cast<String>();
    list.add(json[i]['correctAnswer']);

    list.shuffle();

    return list;
  }

  int getCorrectIndex(int i) {
    for (int j = 0; j < 4; j++) {
      if (questions[i].options[j] == questions[i].answer) {
        return j;
      }
    }
    return 0;
  }

  void populateList(dynamic json) {
    for (var i = 0; i < 10; i++) {
      questions.add(Question(
          question: json[i]['question'],
          answer: json[i]['correctAnswer'],
          options: _createOptions(json, i)));
    }
  }
}
