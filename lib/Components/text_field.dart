import 'package:flutter/material.dart';

class NewTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final double paddingBottom;
  final TextInputAction? action;

  const NewTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.paddingBottom = 12.0,
    this.action,
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
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),

          prefixIcon: Icon(widget.icon),

          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
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
          fillColor: const Color.fromRGBO(236, 236, 249, 1),

          contentPadding: const EdgeInsets.symmetric(vertical: 18),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}