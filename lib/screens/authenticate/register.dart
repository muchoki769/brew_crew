import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({ required this.toggleView, super.key});
  // const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
// final AuthService _auth = AuthService();
  final AuthService _auth = AuthService();
  bool loading = false;

  String email='';
  String password='';
  String error= '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async{
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),

          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                val == null || val.isEmpty
                    ? 'Enter am email'
                    : null,

                onChanged: (val) {
                  setState(() => email = val);
                },

              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder()
                ),
                obscureText: true,
                validator: (val) =>
                val == null || val.length < 6
                    ? 'Enter a password 6+ characters long'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                // color: Colors.orange[400],
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(
                      email,
                      password,
                    );

                    if (result == null) {
                      setState (() {
                          error = 'could not register in with those credentials';
                          loading = false;
                      });
                    }
                    // print('Email: $email');
                    // print('Password: $password');
                  }
                },
                child: const Text(
                  'Register'
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
