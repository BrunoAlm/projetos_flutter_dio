import 'package:mobx/mobx.dart';

part 'counter_mobx_store.g.dart';

class CounterMobXStore = _CounterMobXStore with _$CounterMobXStore;

abstract class _CounterMobXStore with Store {
  @observable
  int counter = 0;

  @action
  void increment() {
    counter++;
  }
}
