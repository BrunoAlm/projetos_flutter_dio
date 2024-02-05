import 'package:mobx/mobx.dart';

class CounterMobxService {
  final _counter = Observable(0);
  int get counter => _counter.value;

  late Action increment;

  CounterMobxService() {
    increment = Action(_increment);
  }

  void _increment() {
    _counter.value++;
  }
}
