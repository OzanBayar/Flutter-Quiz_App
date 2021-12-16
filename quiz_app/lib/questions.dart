import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:quiz_app/answer.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  int totalQuestion = _questions.length;


  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;

      if (_questionIndex >= _questions.length) {
        _resetQuiz();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            left: true,
            right: true,
            bottom: true,
            top: true,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.width * 0.14,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.22,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _questions[_questionIndex]['question'].toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ...(_questions[_questionIndex]['answers']
                          as List<Map<String, Object>>)
                      .map(
                    (answer) => Answer(
                      answerText: answer['answerText'].toString(),
                      answerColor: answerWasSelected
                          ? answer['score'] as bool
                              ? Colors.green
                              : Colors.red
                          : Colors.transparent,
                      answerTap: () {
                        if (answerWasSelected) {
                          return;
                        }
                        _questionAnswered(answer['score'] as bool);
                      },
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(double.infinity, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (!answerWasSelected) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please select an answer!"),
                        ));
                      } else {
                        _nextQuestion();
                      }
                    },
                    icon: Icon(
                        endOfQuiz ? Icons.repeat_outlined : Icons.skip_next),
                    label: Text(endOfQuiz ? "Restart Quiz" : "Next Question"),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  if (endOfQuiz)
                    Container(
                      padding: const EdgeInsets.all(6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.brown),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              endOfQuiz ? "Congratulations! " : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Center(
                            child: Text(
                              endOfQuiz
                                  ? "Your Score : $_totalScore/$totalQuestion "
                                  : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


final _questions = [
  {
    'question': 'Which country has the longest coastline in the world?',
    'answers': [
      {'answerText': 'Russia', 'score': false},
      {'answerText': 'Australia', 'score': false},
      {'answerText': 'Canada', 'score': true},
      {'answerText': 'Indonesia', 'score': false},
    ],
  },
  {
    'question': "What is the world's most populated country?",
    'answers': [
      {'answerText': 'India', 'score': false},
      {'answerText': 'USA', 'score': false},
      {'answerText': 'Japan', 'score': false},
      {'answerText': 'China', 'score': true},
    ],
  },
  {
    'question': "What is the capital of the Philippines?",
    'answers': [
      {'answerText': 'Manila', 'score': true},
      {'answerText': 'Jakarta', 'score': false},
      {'answerText': 'Dili', 'score': false},
      {'answerText': 'Marawi', 'score': false},
    ],
  },
  {
    'question': "What is the World's Smallest Country?",
    'answers': [
      {'answerText': 'Monaco', 'score': false},
      {'answerText': 'Vatican City', 'score': true},
      {'answerText': 'Lichtenstein', 'score': false},
      {'answerText': 'Luxemborg', 'score': false},
    ],
  },
  {
    'question': "In which country is the world's highest waterfall?",
    'answers': [
      {'answerText': 'Brazil', 'score': false},
      {'answerText': 'USA', 'score': false},
      {'answerText': 'Argentina', 'score': false},
      {'answerText': 'Venezuela', 'score': true},
    ],
  },
];
