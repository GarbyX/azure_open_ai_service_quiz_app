import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azure OpenAI Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<Question> _questions = [
    Question(
      'Which tool can you use to deploy AI models and deploy them for public consumption in software applications?',
      ['Azure OpenAI Foundry', 'Azure subscriptions', 'Azure AI services'],
      0,
    ),
    Question(
      'How does Azure OpenAI process text?',
      ['It converts text to hexadecimal format.', 'By breaking it down into tokens', 'By converting it into squares'],
      1,
    ),
    // Add the remaining questions here...
  ];

  void _nextQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correct!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong!')),
      );
    }

    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Azure OpenAI Quiz')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _questions[_currentQuestionIndex].question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ..._questions[_currentQuestionIndex].options.map((option) {
              int index = _questions[_currentQuestionIndex].options.indexOf(option);
              return ElevatedButton(
                onPressed: () => _nextQuestion(index),
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  String question;
  List<String> options;
  int correctAnswer;

  Question(this.question, this.options, this.correctAnswer);
}
