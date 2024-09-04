// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/space.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _nome = TextEditingController();
  final _cognome = TextEditingController();
  bool isLogin = true;
  bool isObscure = true;
  bool isPlay = true;

  Future<void> signIn(BuildContext context) async {
    try {
      if (_password.text.isEmpty || _email.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tutti i campi devono essere compilati'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        await Auth().signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      }
    } on FirebaseAuthException catch (error) {
      String message;
      switch (error.toString()) {
        case '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.':
          message = 'Email o password errata';
          break;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          message = 'L\'indirizzo email fornito è invalido';
          break;

        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
          message =
              'L\'accesso al tuo account è stato temporaneamente sospeso per troppi tentantivi errati. Riprova più tardi.';
          break;

        default:
          message = 'Si è verificato un errore. Riprova.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> createUser(BuildContext context) async {
    try {
      if (_nome.text.isEmpty ||
          _cognome.text.isEmpty ||
          _email.text.isEmpty ||
          _password.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tutti i campi devono essere compilati'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        await Auth().createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        await Auth()
            .setNameAndSurname(name: _nome.text, surname: _cognome.text);
        Auth().createNews(_nome.text, Auth().getUID().toString());
      }
    } on FirebaseAuthException catch (error) {
      String message;
      switch (error.toString()) {
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          message = 'L\'indirizzo email fornito è invalido';
          break;
        default:
          message = 'Errore nella creazione dell\'account. Riprova più tardi.';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 67, 157, 231),
          Color.fromARGB(255, 208, 118, 224)
        ], transform: GradientRotation(3.14))),
        child: Column(
          children: [
            const Space(
              heigth: 70,
              width: double.maxFinite,
            ),
            const Text(
              'Benvenuto su ParaLat',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55, right: 20, left: 20),
              child: Column(
                children: [
                  const Text(
                    'Accedi o Iscriviti per continuare',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Space(heigth: 30, width: double.infinity),
                  if (isLogin == false)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nome,
                            decoration:
                                const InputDecoration(label: Text('nome')),
                          ),
                        ),
                        const Space(heigth: 20, width: 40),
                        Expanded(
                          child: TextField(
                            controller: _cognome,
                            decoration:
                                const InputDecoration(label: Text('cognome')),
                          ),
                        ),
                      ],
                    ),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(label: Text('email')),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      label: const Text('password'),
                      suffixIcon: IconButton(
                        icon: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                  if (isLogin == true)
                    TextButton(
                      child: const Row(
                        children: [
                          Text('Password dimenticata?  '),
                          Icon(Icons.key),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'Inserisci una mail per consentire il recupero della password'),
                                content: SizedBox(
                                  height: 140,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _email,
                                        decoration: const InputDecoration(
                                            label: Text('email')),
                                      ),
                                      const Space(heigth: 30),
                                      TextButton(
                                          onPressed: () {
                                            Auth().reimpostaPassword(
                                                context, true, _email.text);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    const Text('Email inviata'),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .inversePrimary,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Invia email')),
                                    ],
                                  ),
                                )));
                        // Navigator
                        // Auth().reimpostaPassword(context);
                      },
                    ),
                  const Space(
                    heigth: 6,
                    width: double.maxFinite,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        isLogin ? signIn(context) : createUser(context);
                      },
                      child: Text(isLogin ? 'Accedi' : 'Registrati')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isLogin
                          ? 'Non hai un account?'
                          : 'Hai già un account?'),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? 'Registrati' : 'Accedi',
                            style: TextStyle(color: Colors.purple[200]),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
