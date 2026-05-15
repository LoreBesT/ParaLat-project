// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';

class Button extends StatefulWidget {
  ///Bottone per il drawer personalizzabile con icona, testo e pagina di destinazione
  const Button(
      {super.key,
      required this.icona,
      required this.funzione,
      required this.testo,
      this.isWarming,
      this.isPremium});

  final Widget funzione;
  final IconData icona;
  final String testo;
  final bool? isPremium;
  final bool? isWarming;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ButtonStyle(
            animationDuration: const Duration(seconds: 1),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: AppRadius.circularBorder,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(AppColors.cardTile),
          ),
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.funzione,
                  ),
                );
          },
          child: Row(
            children: [
              Icon(
                widget.icona,
                color: (widget.isWarming ?? false) ? AppColors.errorRed : AppColors.gradientStart,
              ),
              const SizedBox(width: 8),
              Text(
                widget.testo,
                style: TextStyle(
                  color:
                      (widget.isWarming ?? false) ? AppColors.errorRed : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
