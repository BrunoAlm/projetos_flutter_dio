import 'package:projetos_flutter_dio/src/modules/chat/chat_login_page.dart';
import 'package:projetos_flutter_dio/src/modules/imc/imc_page.dart';
import 'package:projetos_flutter_dio/src/modules/cep/cep_page.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_page.dart';
import 'package:projetos_flutter_dio/src/modules/marvel/marvel_page.dart';
import 'package:projetos_flutter_dio/src/modules/posts/posts_page.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/tarefas_page.dart';
import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_button.dart';

class MyNavigation extends StatefulWidget {
  final String title;
  const MyNavigation({super.key, required this.title});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int _actualPage = 0;

  List<Widget> allChallenges = [
    const CounterPage(title: 'Contador'),
    const ImcPage(title: 'Calculadora de IMC'),
    const CepPage(title: 'Buscar CEP'),
    const PostsPage(title: 'Posts'),
    const MarvelPage(title: 'API Marvel Comics'),
    const TarefasPage(title: 'Tarefas com Back4App'),
    const ChatLoginPage(title: 'Login chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: const [
          DarkModeButton(),
        ],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Expanded(
                child: NavigationRail(
                  labelType: NavigationRailLabelType.all,
                  leading: const SizedBox(height: 15),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.exposure_plus_1),
                      label: Text('Contador'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.calculate),
                      label: Text('Calculadora IMC'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.my_location),
                      label: Text('Buscar CEP'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.web),
                      label: Text('Postagem'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_4_rounded),
                      label: Text('Marvel'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.cloud_upload),
                      label: Text('Tarefas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chat),
                      label: Text('Chat'),
                    ),
                  ],
                  selectedIndex: _actualPage,
                  onDestinationSelected: (value) {
                    setState(() {
                      _actualPage = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: allChallenges[_actualPage],
          )
        ],
      ),
    );
  }
}
