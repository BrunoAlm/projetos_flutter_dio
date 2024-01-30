import 'package:first_proj_flutter_dio/main.dart';
import 'package:first_proj_flutter_dio/src/calculate_imc/services/calculate_imc_services.dart';
import 'package:first_proj_flutter_dio/src/calculate_imc/imc_hive_config.dart';
import 'package:first_proj_flutter_dio/src/calculate_imc/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CalculateImcScreen extends StatefulWidget {
  final String title;
  const CalculateImcScreen({super.key, required this.title});

  @override
  State<CalculateImcScreen> createState() => _CalculateIMCWidmctState();
}

class _CalculateIMCWidmctState extends State<CalculateImcScreen> {
  final ImcHiveConfig _hiveConfig = di();

  String valorIMC = '';
  String classificacaoIMC = '';

  final nomeEC = TextEditingController();
  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();

  @override
  void initState() {
    _hiveConfig.initDB();
    super.initState();
  }

  @override
  void dispose() {
    alturaEC.dispose();
    pesoEC.dispose();
    nomeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('IMC =', style: Theme.of(context).textTheme.titleLarge),
                const VerticalDivider(),
                Flexible(
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: alturaEC,
                          label: 'Altura (m)',
                        ),
                        const Divider(
                          height: 15,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        CustomTextField(
                          controller: pesoEC,
                          label: 'Peso (Kg)',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      valorIMC = CalculateIMCServices.calcularIMC(
                        double.parse(pesoEC.text.trim()),
                        double.parse(alturaEC.text.trim()),
                      );
                      classificacaoIMC = CalculateIMCServices.classificarIMC(
                        double.parse(valorIMC),
                      );
                      _hiveConfig.box.put('valorIMC', valorIMC);
                      _hiveConfig.box.put('classificacaoIMC', classificacaoIMC);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text('Calcular'),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hiveConfig.box.get('valorIMC') != null
                        ? Text(
                            'Seu IMC é: ${_hiveConfig.box.get('valorIMC')}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : const SizedBox.shrink(),
                    _hiveConfig.box.get('classificacaoIMC') != null
                        ? Text(
                            "Sua classificação é: ${_hiveConfig.box.get('classificacaoIMC')}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
