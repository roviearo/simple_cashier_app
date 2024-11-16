import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simple_cashier_app/core/utils/router.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';
import 'package:simple_cashier_app/src/authentication/presentation/local_database/local_database_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/list_category/list_category_cubit.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isLogin = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            router.pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is Loading) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (state is Authenticated) {
            context.read<LocalDatabaseCubit>().loadLocalDatabase();
            context.read<ListCategoryCubit>().getListCategory();
            router.goNamed('main');
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tolong diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            isObscure = !isObscure;
                          }),
                          icon: SvgPicture.asset(
                            isObscure ? 'icons/eye_close.svg' : 'icons/eye.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.outline,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      obscureText: isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tolong diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isLogin) {
                            context.read<AuthenticationBloc>().add(SignInEvent(
                                emailController.text, passwordController.text));
                          } else {
                            context.read<AuthenticationBloc>().add(SignUpEvent(
                                emailController.text, passwordController.text));
                          }
                        }
                      },
                      child: Text(isLogin ? 'Login' : 'Register'),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? 'Belum punya akun? Daftar disini.'
                          : 'Sudah punya akun? Masuk disini.'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
