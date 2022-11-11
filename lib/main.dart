import 'package:flutter/material.dart';
import 'package:flutter_application_4/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context)
                          .add(CounterIncEvent());
                    },
                    icon: const Icon(
                      Icons.plus_one_sharp,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context)
                          .add(CounterDecEvent());
                    },
                    icon: const Icon(
                      Icons.plus_one_sharp,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              body: Center(
                child: Text(
                  state.toString(),
                  style: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
