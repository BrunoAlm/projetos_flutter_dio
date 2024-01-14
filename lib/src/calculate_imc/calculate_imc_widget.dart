import 'package:first_proj_flutter_dio/src/calculate_imc/calculate_imc_services.dart';
import 'package:flutter/material.dart';

class CalculateImcWidget extends StatefulWidget {
  final String title;
  const CalculateImcWidget({super.key, required this.title});

  @override
  State<CalculateImcWidget> createState() => _CalculateIMCWidmctState();
}

class _CalculateIMCWidmctState extends State<CalculateImcWidget> {
  String valorIMC = '';
  String classificacaoIMC = '';

  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // implementar classe Pessoa
    super.initState();
  }

  @override
  void dispose() {
    alturaEC.dispose();
    pesoEC.dispose();
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
                    valorIMC.isNotEmpty
                        ? Text(
                            'Seu IMC é: $valorIMC',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : const SizedBox.shrink(),
                    classificacaoIMC.isNotEmpty
                        ? Text(
                            "Sua classificação é: $classificacaoIMC",
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

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
