import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cashier_app/core/services/injection_container.dart';
import 'package:simple_cashier_app/core/utils/color_schemes.g.dart';
import 'package:simple_cashier_app/core/utils/env.dart';
import 'package:simple_cashier_app/core/utils/simple_bloc_observer.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  Bloc.observer = SimpleBlocObserver();

  await init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>()..add(const AppStarted()),
      child: MaterialApp.router(
        title: 'Simple Cashier Appp',
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
          fontFamily: 'Poppins',
          iconTheme: IconThemeData(
            color: lightColorScheme.primary,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
          fontFamily: 'Poppins',
          iconTheme: IconThemeData(
            color: darkColorScheme.primary,
          ),
        ),
      ),
    );
  }
}
