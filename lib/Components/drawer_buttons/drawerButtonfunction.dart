import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/custom_snackbar.dart';

class ButtonFunction extends StatefulWidget {
  const ButtonFunction({
    super.key,
    required this.icona,
    required this.funzione,
    required this.testo,
    required this.subtitle,
    required this.snackmessage,
    this.isWarming,
    this.isPremium,
  });

  final Future<void> Function(BuildContext context) funzione; // 👈 chiave
  final IconData icona;
  final String testo;
  final String subtitle;
  final String snackmessage;
  final bool? isPremium;
  final bool? isWarming;

  @override
  State<ButtonFunction> createState() => _ButtonFunctionState();
}

class _ButtonFunctionState extends State<ButtonFunction> {
  @override
  Widget build(BuildContext context) {
    final isWarning = widget.isWarming ?? false;

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
            backgroundColor:
                WidgetStateProperty.all(AppColors.cardTile),
          ),
          onPressed: () async {
            await widget.funzione(context);
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(widget.snackmessage, type: SnackBarType.success),
      );
          },
          child: Row(
            children: [
              Icon(
                widget.icona,
                color: isWarning
                    ? AppColors.errorRed
                    : AppColors.gradientStart,
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.testo,
                    style: TextStyle(
                      // fontSize: 14,
                      color: isWarning
                          ? AppColors.errorRed
                          : AppColors.text,
                    ),
                  ),
                  Text(widget.subtitle, style: TextStyle(fontSize: 12),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
