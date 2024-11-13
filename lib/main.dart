import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cashier_app/core/services/injection_container.dart';
import 'package:simple_cashier_app/core/utils/color_schemes.g.dart';
import 'package:simple_cashier_app/core/utils/env.dart';
import 'package:simple_cashier_app/core/utils/router.dart';
import 'package:simple_cashier_app/core/utils/simple_bloc_observer.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/add_category/add_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/delete_category/delete_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/list_category/list_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/update_category/update_category_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<AuthenticationBloc>()..add(const AppStarted())),
        BlocProvider(create: (context) => sl<AddCategoryCubit>()),
        BlocProvider(create: (context) => sl<DeleteCategoryCubit>()),
        BlocProvider(create: (context) => sl<ListCategoryCubit>()),
        BlocProvider(create: (context) => sl<UpdateCategoryCubit>()),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
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
