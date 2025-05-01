import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azure OpenAI Quiz',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  int _score = 0;

  List<Question> _questions = [
    Question(
      'Which tool can you use to deploy AI models for public consumption?',
      ['Azure OpenAI Foundry', 'Azure subscriptions', 'Azure AI services'],
      0,
    ),
    Question(
      'How does Azure OpenAI process text?',
      ['It converts text to hexadecimal format.', 'By breaking it down into tokens', 'By converting it into squares'],
      1,
    ),
    Question(
      'What kind of billing do Standard deployments provide for Azure OpenAI?',
      ['Pay-per-token billing model', 'Prepaid billing model', 'Provisioned billing model'],
      0,
    ),
    Question(
      'What’s the unit of management for a specific OpenAI model?',
      ['Azure OpenAI Service', 'Azure OpenAI Deployment', 'Azure OpenAI Foundry'],
      1,
    ),
    Question(
      'Which type of deployment is appropriate for non-latency-sensitive workloads?',
      ['Global-Batch', 'Global-Standard', 'Provisioned'],
      0,
    ),
    Question(
      'What enables the assignment of rate limits to Azure OpenAI deployments?',
      ['Azure OpenAI quota', 'Azure subscriptions', 'Azure AI services'],
      0,
    ),
    Question(
      'What’s the unit for sizing provisioned throughput deployments?',
      ['Tokens-per-Minute (TPM)', 'Provisioned throughput unit (PTU)', 'Requests-Per-Minute (RPM)'],
      0,
    ),
    Question(
      'What must you have in each region where you intend to create a provisioned Azure OpenAI deployment?',
      ['Azure OpenAI resource', 'Azure OpenAI Service', 'Azure OpenAI model'],
      0,
    ),
    Question(
      'By default, on what basis are you charged when deploying Azure OpenAI provisioned?',
      ['Daily', 'Hourly', 'Monthly'],
      1,
    ),
    Question(
      'What’s the minimum reservation period for Azure OpenAI provisioned?',
      ['One day', 'One month', 'One year'],
      2,
    ),
    Question(
      'What happens when Azure reservation expires?',
      ['Deployments continue at hourly rate', 'Deployments stop', 'Deployments continue at monthly rate'],
      0,
    ),
    Question(
      'Can you update the reservation scope after purchase?',
      ['Yes', 'No'],
      1,
    ),
    Question(
      'Can Azure OpenAI Service provisioned reservations be exchanged?',
      ['Yes', 'No'],
      1,
    ),
    Question(
      'Which cost data shows reservation consumption value?',
      ['Actual cost data', 'Amortized cost data'],
      1,
    ),
  ];

  void _nextQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(score: _score, total: _questions.length),
      ),
    );
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
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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

class ResultsScreen extends StatelessWidget {
  final int score;
  final int total;

  ResultsScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You scored $score out of $total!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
