import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess My Number',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Guess My Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int guessedNumber = Random().nextInt(100);
  int amount = 0;
  String buttonText = 'Guess';
  String guessText = '';
  final _formKey = GlobalKey<FormState>();

  void _guess() {
    print('Guessed value is $guessedNumber');

    if (amount == guessedNumber) {
      guessText = 'You tried $amount, you guessed right!';
      buttonText = 'Reset';
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('You guessed right!'),
                content: Text('It was $guessedNumber'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _reset();
                      },
                      child: const Text('Try again')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'))
                ],
              ));
    } else if (amount > guessedNumber) {
      guessText = 'You tried $amount, try lower!';
    } else if (amount < guessedNumber) {
      guessText = 'You tried $amount, try higher!';
    }
    setState(() {});
  }

  void _reset() {
    setState(() {
      guessedNumber = Random().nextInt(100);
      guessText = '';
      buttonText = 'Guess';
    });

    print('Guessed value is $guessedNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
            child: Text(widget.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, fontSize: 30))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            const Text('I am thinking of a number between 1 and 100.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30)),
            const SizedBox(height: 40),
            const Text('It\'s your turn to guess my number!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25)),
            const SizedBox(height: 40),
            Text(guessText,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 25)),
            Card(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 350,
                height: 200,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Try a number!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 25)),
                    SizedBox(
                      width: 250,
                      child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: TextFormField(
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                amount = int.tryParse(value) ?? 0;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.onSurface),
                      ),
                      onPressed: () {
                        _formKey.currentState!.validate();

                        if (buttonText == 'Reset') {
                          _reset();
                        } else {
                          _guess();
                        }
                      },
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
