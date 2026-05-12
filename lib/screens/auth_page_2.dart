import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/custom_snackbar.dart';
import 'package:paralat/Components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paralat/Components/auth.dart';

//fixare il fatto che con la dark mode nn si leggono bene i testi

class AuthPage2 extends StatefulWidget {
  const AuthPage2({super.key});
  @override
  State<AuthPage2> createState() => _AuthPage2State();
}

class _AuthPage2State extends State<AuthPage2> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();
  final _nome = TextEditingController();
  final _cognome = TextEditingController();
  bool isLogin = true;

  Future<void> signIn(BuildContext context) async {
    try {
      if (_password.text.isEmpty || _email.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar("Tutti i campi devono essere compilati",
              type: SnackBarType.error),
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
        customSnackBar(message, type: SnackBarType.error),
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
          customSnackBar("Tutti i campi devono essere compilati",
              type: SnackBarType.error),
        );
      } else if (_password.text != _repassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar("Le password non coincidono",
              type: SnackBarType.error),
        );
      } else {
        await Auth().createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        await Auth()
            .setNameAndSurname(name: _nome.text, surname: _cognome.text);
        Auth().createAvvisoBenvenuto(_nome.text, Auth().getUID().toString());
      }
    } on FirebaseAuthException catch (error) {
      String message;
      switch (error.toString()) {
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          message = 'L\'indirizzo email fornito è invalido';
          break;
        default:
          message = 'Errore nella creazione dell\'account. Riprova più tardi.\nErrore: ${error.toString()}';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(message, type: SnackBarType.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.circularBorder,
                    ),

                    // 🔥 FIX AUTOFILL: solo login fields dentro AutofillGroup
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: AutofillGroup(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                r'assets/images/logoApp.png',
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                isLogin
                                    ? 'Bentornato su ParaLat'
                                    : 'Crea il tuo account',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                isLogin
                                    ? 'Accedi al tuo account'
                                    : 'Compila i campi per registrarti',
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 18),

                              if (isLogin == false)
                                Row(
                                  children: [
                                    Expanded(
                                        child: NewTextField(
                                            controller: _nome,
                                            hint: "Nome",
                                            icon: Icons.person_outline)),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: NewTextField(
                                            controller: _cognome,
                                            hint: "Cognome",
                                            icon: Icons.person_outline)),
                                  ],
                                ),

                              NewTextField(
                                controller: _email,
                                hint: "Email",
                                icon: Icons.email,

                                // 🔥 FIX AUTOFILL
                                autofillHints: const [
                                  AutofillHints.email,
                                  AutofillHints.username,
                                ],
                              ),

                              NewTextField(
                                controller: _password,
                                hint: "Password",
                                icon: Icons.lock_outline_rounded,
                                isPassword: true,

                                // 🔥 FIX AUTOFILL
                                autofillHints: const [
                                  AutofillHints.password,
                                ],

                                paddingBottom: isLogin ? 0.0 : 12.0,
                              ),

                              if (isLogin == true)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        builder: (BuildContext context) {
                                          return SafeArea(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 20,
                                                bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom +
                                                    20,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Inserisci una mail per consentire il recupero della password',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  NewTextField(
                                                    controller: _email,
                                                    hint: "Email",
                                                    icon: Icons.email,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            AppRadius.circularBorder,
                                                        gradient: const LinearGradient(
                                                          begin: Alignment.centerLeft,
                                                          end: Alignment.centerRight,
                                                          colors: [
                                                            AppColors.gradientStart,
                                                            AppColors.gradientEnd
                                                          ],
                                                        ),
                                                      ),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Auth().reimpostaPassword(
                                                            context,
                                                            true,
                                                            _email.text,
                                                          );
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(
                                                            customSnackBar(
                                                                'Email inviata! Controlla la tua casella di posta',
                                                                type: SnackBarType
                                                                    .success),
                                                          );
                                                          Navigator.pop(context);
                                                        },
                                                        style:
                                                            ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.transparent,
                                                          shadowColor:
                                                              Colors.transparent,
                                                        ),
                                                        child: const Text(
                                                          'Invia email',
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Password dimenticata?",
                                      style: TextStyle(
                                        color: AppColors.gradientStart,
                                      ),
                                    ),
                                  ),
                                ),

                              if (isLogin == false)
                                NewTextField(
                                    controller: _repassword,
                                    hint: "Conferma Password",
                                    icon: Icons.lock_outline_rounded,
                                    isPassword: true),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: AppRadius.circularBorder,
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      AppColors.gradientStart,
                                      AppColors.gradientEnd
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    TextInput.finishAutofillContext(shouldSave: true);
                                    isLogin
                                        ? signIn(context)
                                        : createUser(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  child: Text(
                                    isLogin ? "Accedi" : "Registrati",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

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
                                        style: const TextStyle(
                                            color: AppColors.gradientStart,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}