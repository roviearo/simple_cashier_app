import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/list_category/list_category_cubit.dart';

import '../../../../core/utils/router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          context.read<ListCategoryCubit>().getListCategory();
          await Future.delayed(const Duration(seconds: 3))
              .then((value) => router.goNamed('main'));
        } else if (state is OfflineAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Anda sedang dalam mode offline')));
          context.read<ListCategoryCubit>().getListCategory();
          await Future.delayed(const Duration(seconds: 3))
              .then((value) => router.goNamed('main'));
        } else {
          await Future.delayed(const Duration(seconds: 3))
              .then((value) => router.goNamed('login_register'));
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
