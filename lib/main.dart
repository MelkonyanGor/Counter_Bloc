import 'package:flutter/material.dart';
import 'package:flutter_application_4/counter_bloc.dart';
import 'package:flutter_application_4/user_bloc/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterbloc = CounterBloc()..add(CounterDecEvent());
    final userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                counterbloc.add(CounterIncEvent());
              },
              icon: const Icon(
                Icons.plus_one_sharp,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                counterbloc.add(CounterDecEvent());
              },
              icon: const Icon(
                Icons.exposure_minus_1,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                userBloc.add(UserGetUsersEvent(counterbloc.state));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CounterBloc, int>(
                bloc: counterbloc,
                builder: (context, state) {
                  return Center(
                    child: Text(
                      state.toString(),
                      style: const TextStyle(
                        fontSize: 33.0,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                bloc: userBloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state is UserLoadingState)
                        const CircularProgressIndicator(),
                      if (state is UserLoadedState)
                        ...state.users.map((e) => Text(e.name)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
