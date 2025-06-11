import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/authentication/login/login_page.dart';
import 'package:wattsup/pages/welcome_page/welcome.dart';
import 'package:wattsup/utils/theme/colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numeroController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _identifiantCompteurController = TextEditingController();
  final _numeroCompteurController = TextEditingController();
  final _exploitationController = TextEditingController();
  final _referenceController = TextEditingController();
  final _typeClientController = TextEditingController();
  bool _obscureText = true;
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
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Informations sur le client",
                      style: GoogleFonts.poppins(
                        color: TColors.textWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre nom";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Nom",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
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
                controller: _surnameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre prénom";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Prénom",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
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
                controller: _numeroController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre numéro";
                  }
                  if (value.length < 10 ||
                      value.length > 10 ||
                      !RegExp(r"^\d+$").hasMatch(value)) {
                    return "Veuillez entrez un numéro de téléphone valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Numéro de téléphone",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.phone_android,
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
                  if (value.length < 8) {
                    return "Votre mot de passe doit contenir au moins 8 lettres";
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
              TextFormField(
                controller: _confirmPasswordController,
                style: GoogleFonts.poppins(color: TColors.textWhite),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez le même mot de passe";
                  }
                  if (value != _passwordController.text) {
                    return "Les deux mots de passe doivent être identiques";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Confirmation du mot de passe",
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
              SizedBox(height: 30),
              Text(
                "Informations sur le compteur",
                style: GoogleFonts.poppins(
                  color: TColors.textWhite,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _identifiantCompteurController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre identifiant de compteur";
                  }
                  if (!RegExp(r"^\d+$").hasMatch(value) || value.length < 10) {
                    return "Veuillez entrez un identifiant de compteur valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Identifiant de compteur",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
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
                controller: _numeroCompteurController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre numéro de compteur";
                  }
                  if (!RegExp(r"^\d+$").hasMatch(value) || value.length < 9) {
                    return "Veuillez entrez un numéro de compteur valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Identifiant de compteur",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
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
                controller: _exploitationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre exploitation";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Exploitation",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.location_city,
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
                controller: _referenceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre référence de compteur";
                  }
                  if (!RegExp(r"^\d+$").hasMatch(value) || value.length < 10) {
                    return "Veuillez entrez un numéro de référence valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Référence",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
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
                controller: _typeClientController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrez votre type de client";
                  }
                  if (!RegExp(r"^\d+$").hasMatch(value) || value.length > 2) {
                    return "Veuillez entrez un type de client valide";
                  }
                  return null;
                },
                style: GoogleFonts.poppins(color: TColors.textWhite),
                decoration: InputDecoration(
                  labelText: "Type de client",
                  labelStyle: GoogleFonts.poppins(
                    color: TColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
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
              SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  }
                },
                height: 45,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: TColors.orange,
                child: Text(
                  "S'inscrire",
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
                    "Vous avez déjà un compte?",
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
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                    },
                    child: Text(
                      "Se connecter",
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
}
