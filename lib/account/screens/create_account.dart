import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/account/bloc/account_bloc.dart';
import 'package:vision_ex_digital_practical/account/models/account.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:vision_ex_digital_practical/house/screens/home_screen.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final accountCubit = BlocProvider.of<AccountCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => username = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await accountCubit.saveAccount(
                      Account(username: username, email: email),
                    );
                    if (context.mounted) {
                      context.read<HouseCubit>().getHouseData();
                    }
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
                child: const Text('Save Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
