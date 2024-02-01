import 'package:first_proj_flutter_dio/src/modules/imc/imc_page.dart';
import 'package:first_proj_flutter_dio/src/modules/cep/cep_page.dart';
import 'package:first_proj_flutter_dio/src/modules/first_commit/first_commit_page.dart';
import 'package:first_proj_flutter_dio/src/modules/marvel/marvel_page.dart';
import 'package:first_proj_flutter_dio/src/modules/posts/posts_page.dart';
import 'package:flutter/material.dart';

class MyNavigation extends StatefulWidget {
  final String title;
  const MyNavigation({super.key, required this.title});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int _actualPage = 0;

  List<Widget> allChallenges = [
    const FirstCommitPae(title: 'Primeiro Commit'),
    const ImcPage(title: 'Calculadora de IMC'),
    const CepPage(title: 'Consulta de CEP'),
    const PostsPage(title: 'Posts'),
    const MarvelPage(title: 'API Marvel Comics'),
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
              NavigationRailDestination(
                icon: Icon(Icons.my_location),
                label: Text('Consulta CEP'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.web),
                label: Text('Postagem'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_4_rounded),
                label: Text('Marvel'),
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
                child: allChallenges[_actualPage],
              ),
            ),
          )
        ],
      ),
    );
  }
}
