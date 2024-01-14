import 'package:first_proj_flutter_dio/src/calculate_imc/calculate_imc_widget.dart';
import 'package:first_proj_flutter_dio/src/first_commit/first_commit_widget.dart';
import 'package:flutter/material.dart';

class MyNavigation extends StatefulWidget {
  final String title;
  const MyNavigation({super.key, required this.title});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int _actualPage = 0;

  List<Widget> paginasDesafios = [
    const MyHomePage(title: 'Primeiro Commit'),
    const CalculateImcWidget(title: 'Calculadora IMC'),
    const MyHomePage(title: 'Terceiro Commit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            leading: const SizedBox(height: 15),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Primeiro commit'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calculate),
                label: Text('Calculadora IMC'),
              ),
            ],
            selectedIndex: _actualPage,
            onDestinationSelected: (value) {
              setState(() {
                _actualPage = value;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: paginasDesafios[_actualPage],
              ),
            ),
          )
        ],
      ),
    );
  }
}
