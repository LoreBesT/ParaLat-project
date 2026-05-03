import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';

class NewTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final double paddingBottom;
  final TextInputAction? action;

  // 🔥 AGGIUNTO: supporto autofill
  final List<String>? autofillHints;

  const NewTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.paddingBottom = 12.0,
    this.action,
    this.autofillHints, // 🔥 AGGIUNTO QUI
  });

  @override
  State<NewTextField> createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<NewTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingBottom),
      child: TextField(
        controller: widget.controller,

        obscureText: widget.isPassword ? _obscureText : false,
        textInputAction: widget.action,

        // 🔥 FIX AUTOFILL (ORA CORRETTO)
        autofillHints: widget.autofillHints,

        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,

        enableSuggestions: !widget.isPassword,
        autocorrect: !widget.isPassword,

        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),

          prefixIcon: Icon(widget.icon),

          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,

          filled: true,
          fillColor: /*Auth().isDarkTheme(context)
              ? const Color.fromARGB(255, 47, 47, 47)
              :*/ const Color.fromRGBO(236, 236, 249, 1),

          contentPadding: const EdgeInsets.symmetric(vertical: 18),

          border: OutlineInputBorder(
            borderRadius: AppRadius.circularBorder,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}