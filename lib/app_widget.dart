import 'package:projetos_flutter_dio/my_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_service.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(
          create: (context) => DarkModeService(),
        )
      ],
      child: Consumer<DarkModeService>(
        builder: (context, darkModeService, child) => MaterialApp(
          title: 'Flutter DIO',
          theme:
              darkModeService.darkMode ? ThemeData.light() : ThemeData.dark(),
          home: const MyNavigation(title: 'Desafios DIO'),
        ),
      ),
    );
  }
}