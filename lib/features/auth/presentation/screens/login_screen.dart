import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/core/helpers/event_status.dart';
import 'package:owwn_flutter_test/core/helpers/validators.dart';
import 'package:owwn_flutter_test/features/auth/presentation/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 48),
            Form(
              key: _formKey,
              child: TextFormField(
                initialValue: 'mza2rintareh@gmail.com',
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email address',
                ),
                validator: (value) {
                  if (!stringIsEmail(value ?? '')) {
                    return 'Pleaae input a proper email address';
                  }
                  email = value!;
                  return null;
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 32,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.status == EventStatus.error) {
                    final errMessage = state.error?.errMessage;
                    return Text(
                      'There was an errror logging you in.${errMessage == null ? '' : '\n$errMessage'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (prev, curr) => prev.status != curr.status,
              builder: (context, state) {
                if (state.status == EventStatus.loading) {
                  return const ElevatedButton(
                    key: ValueKey('email-form'),
                    onPressed: null,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return ElevatedButton(
                  key: const ValueKey('email-form'),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.read<AuthBloc>().add(SignIn(email));
                  },
                  child: const Text('Log In'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
