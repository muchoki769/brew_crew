import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({ required this.toggleView, super.key});
  // const SignIn({super.key});



  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  String email='';
  String password='';
  String error= '';

  //
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold( // ? is a tanary operator if loading is true show loading
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async{
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),

          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Expanded(
                child: Image.asset(
                "assets/mobile-shopping.png",
                width: 150,
                height: 150,
                fit: BoxFit.contain ,

              ),
              ),



              // Icon(
              //     Icons.shopping_bag,
              //   size: 100,
              //   color: Theme.of(context).colorScheme.inversePrimary,
              //
              //
              // ),
              const SizedBox(height: 20.0,),

              const Text(
                "Sunrise Shopping Mall",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )
              ),

              const SizedBox(height: 20.0,),
              Text("Premium Quality Products",
                  style:TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
              ),

              const SizedBox(height: 20.0),

              TextFormField(
                decoration: const InputDecoration(
                  // hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter an email' :null,

                onChanged: (val) {
                  setState(()  => email = val);


                  },

              ),
             const  SizedBox(height: 20.0,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
                obscureText: true,
                validator: (val) => val == null || val.length < 6 ? 'Enter a password 6+ characters long' : null,
                onChanged: (val) {
                  setState(()  => password = val);

                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                // color: Colors.orange[400],
                onPressed: () async {
                  // final AuthService auth = AuthService();
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(
                      email,
                      password,
                    );

                 if (result == null) {
                   setState (() {
                   error = 'could not sign in with those credentials';
                   loading = false;
                   });
                 }
                  }
                  // print(email);
                  // print(password);


                },
                child: const  Text(
                    'sign in',
                     style: TextStyle(color: Colors.black),
                  ),
              ),
              SizedBox(height: 20.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              //other way of implementing a button
              // MyButton(
              //   onTap: () => Navigator.pushNamed(context, '/shop_page'),
              //   child: const Icon(Icons.arrow_forward),
              // ),
            ],
          ),
        ),
        // child: ElevatedButton(
        //   child: Text('Sign in Anonymously'),
        //   onPressed: () async {
        //     final AuthService auth = AuthService();
        //     dynamic result = await auth.signInAnon();
        //     if (result == null){
        //       print('error signing in ');
        //     }else {
        //       print('signed in');
        //       print(result.uid);
        //
        //     }


          //   AuthService authService = AuthService();
          //   User? user = await authService.signInAnon();
          //   if (user != null) {
          //     print ('Signed in anonymously: ${user.uid}');
          //
          //   }else {
          //     print('Failed to Sign in anonymously ');
          //   }
          //
          // },
        // ),
      ),
    );
  }
}
