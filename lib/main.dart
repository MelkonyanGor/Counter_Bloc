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
      debugShowCheckedModeBanner: false,
      home: Wraper(),
    );
  }
}

class Wraper extends StatelessWidget {
  const Wraper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                final counterbloc = context.read<CounterBloc>();
                counterbloc.add(CounterIncEvent());
              },
              icon: const Icon(
                Icons.plus_one_sharp,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                  final counterbloc = context.read<CounterBloc>();
                counterbloc.add(CounterDecEvent());
              },
              icon: const Icon(
                Icons.exposure_minus_1,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                 final userBloc = context.read<UserBloc>();
                userBloc.add(UserGetUsersEvent(context.read<CounterBloc>().state));
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
                // bloc: counterbloc,
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
                // bloc: userBloc,
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
      );
    });
  }
}
