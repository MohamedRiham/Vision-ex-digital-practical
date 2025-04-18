import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/account/bloc/account_bloc.dart';
import 'package:vision_ex_digital_practical/account/models/account.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:vision_ex_digital_practical/house/screens/general_house_details_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  bool _isSuccess = false;
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
                    try {
                      _formKey.currentState!.save();
                      await accountCubit.saveAccount(
                        Account(username: username, email: email),
                      );
                      if (context.mounted) {
                        context.read<HouseCubit>().getHouseData();
                      }
                      if (context.mounted) {
                        setState(() {
                          _isSuccess = true;
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GeneralHouseDetailsScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        });
                      }
                    } catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('An error occurred, please try again'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Save Account'),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _isSuccess ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
