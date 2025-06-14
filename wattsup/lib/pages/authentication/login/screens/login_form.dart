import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wattsup/models/user.dart';
import 'package:wattsup/pages/authentication/register/register_page.dart';
import 'package:wattsup/pages/navigation/navigation.dart';
import 'package:wattsup/providers/user_provider.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:wattsup/constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  List<User> myUsers = [];

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse("$api/utilisateurs/"));
      var data = json.decode(response.body);
      data["results"].forEach((user) {
        User u = User(
          identifiant: user["identifiant"],
          nom: user["nom"],
          prenom: user["prenom"],
          email: user["email"],
          numero_tel: user["numero_tel"],
          mot_de_passe: user["mot_de_passe"],
        );
        myUsers.add(u);
      });
      print(myUsers);
    } catch (e) {
      print("Error is $e");
    }
  }

  void checkLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = myUsers.firstWhereOrNull(
      (u) => u.email == email && u.mot_de_passe == password,
    );

    if (user != null) {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _successMessage(context);
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _errorMessage(context);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          color: TColors.secondary,
          border: Border(top: BorderSide(color: TColors.orange, width: 4)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 60),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre email";
                  }
                  if (!RegExp(r"^\S+@\S+\.\S+$").hasMatch(value)) {
                    return "Veuillez entrez un email valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: TColors.orange,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.orange, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                style: GoogleFonts.poppins(color: TColors.textWhite),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre mot de passe";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Icons.key, color: TColors.orange, size: 18),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      Icons.visibility,
                      color: TColors.orange,
                      size: 18,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.orange, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Mot de passe oublié?",
                      style: GoogleFonts.poppins(
                        color: TColors.textWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkLogin();
                  }
                },
                height: 45,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: TColors.orange,
                child: Text(
                  "Se connecter",
                  style: GoogleFonts.poppins(
                    color: TColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n'avez pas encore de compte?",
                    style: GoogleFonts.poppins(
                      color: TColors.textWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "S'inscrire",
                      style: GoogleFonts.poppins(
                        color: TColors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 90,
          decoration: const BoxDecoration(
            color: TColors.success,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: TColors.textWhite, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Succès",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: TColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Connexion réussie",
                      style: GoogleFonts.poppins(
                        color: TColors.textWhite,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 10,
      ),
    );
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 90,
          decoration: const BoxDecoration(
            color: TColors.error,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: TColors.textWhite, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connexion échoué",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: TColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Vérifiez votre email ou votre mot de passe",
                      style: GoogleFonts.poppins(
                        color: TColors.textWhite,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
    );
  }
}
