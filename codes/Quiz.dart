import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Madrid'],
      'answer': 'Paris',
    },
    {
      'question': 'Who developed the theory of relativity?',
      'options': ['Newton', 'Einstein', 'Galileo', 'Tesla'],
      'answer': 'Einstein',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'answer': 'Mars',
    },
  ];

  int currentQuestionIndex = 0;
  String selectedAnswer = '';
  int score = 0;

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswer = '';
    });
  }

  void nextQuestion() {
    setState(() {
      if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
        score++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswer = '';
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: score,
              onRestart: resetQuiz,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Quiz Competition')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ...questions[currentQuestionIndex]['options'].map((option) {
              return RadioListTile<String>(
                value: option,
                groupValue: selectedAnswer,
                title: Text(option),
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value!;
                  });
                },
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedAnswer.isEmpty ? null : nextQuestion,
              child: Text(currentQuestionIndex == questions.length - 1
                  ? 'Submit'
                  : 'Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const ResultScreen({super.key, required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You scored $score out of 3!',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onRestart();
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
