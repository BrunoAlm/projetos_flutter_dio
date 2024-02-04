import 'package:flutter/material.dart';

class FirstCommitPae extends StatefulWidget {
  const FirstCommitPae({super.key, required this.title});

  final String title;

  @override
  State<FirstCommitPae> createState() => _FirstCommitPaeState();
}

class _FirstCommitPaeState extends State<FirstCommitPae> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Essa é a HomePage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Você pressionou o botão:',
            ),
            Text(
              '$_counter vezes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}