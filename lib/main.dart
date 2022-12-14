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
    return Builder(
      builder: (context) {
        return Scaffold(
          floatingActionButton: BlocConsumer<CounterBloc, int>(
            listenWhen: (previous, current) => previous > current,
            listener: (context, state) {
              if (state == 0) {
                Scaffold.of(context).showBottomSheet(
                  (context) => Container(
                    color: Colors.blue,
                    height: 30.0,
                    width: double.infinity,
                    child: const Text('Your state is 0'),
                  ),
                );
              }
            },
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.toString()),
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
                    userBloc.add(
                        UserGetUsersEvent(context.read<CounterBloc>().state));
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                BlocBuilder<CounterBloc, int>(
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
      },
    );
  }
}
