import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncEvent>(_onIncriment);
    on<CounterDecEvent>(_onDecriment);
  }

  _onIncriment(CounterIncEvent event, Emitter<int> emitter) {
    emitter(state + 1);
  }

  _onDecriment(CounterDecEvent event, Emitter<int> emitter) {
    if (state <= 0) return;
    emitter(state - 1);
  }
}

abstract class CounterEvent {}

class CounterIncEvent extends CounterEvent {}

class CounterDecEvent extends CounterEvent {}
