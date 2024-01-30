class CalculateIMCServices {
  static String calcularIMC(double peso, double altura) =>
      (peso / (altura * altura)).toStringAsFixed(2);

  static String classificarIMC(double imc) {
    if (imc < 18.5) {
      return 'Baixo peso';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Peso normal';
    } else if (imc >= 25.0 && imc < 29.9) {
      return 'Excesso de peso';
    } else if (imc >= 30.0 && imc < 35) {
      return 'Obesidade de Classe 1';
    } else if (imc >= 35.0 && imc < 39.9) {
      return 'Obesidade de Classe 2';
    } else if (imc >= 40) {
      return 'Obesidade de Classe 3';
    } else {
      return '';
    }
  }
}
