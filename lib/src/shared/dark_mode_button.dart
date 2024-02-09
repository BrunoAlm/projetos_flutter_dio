import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_service.dart';
import 'package:provider/provider.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Consumer<DarkModeService>(
        builder: (context, darkModeService, child) => IconButton(
          onPressed: () => darkModeService.darkMode = !darkModeService.darkMode,
          icon: Icon(
            darkModeService.darkMode ? Icons.dark_mode : Icons.light_mode,
          ),
        ),
      ),
    );
  }
}
