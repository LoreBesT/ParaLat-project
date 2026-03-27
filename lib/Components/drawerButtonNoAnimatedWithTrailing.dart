import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ButtonNoAnimatedTr extends StatefulWidget {
  /// Bottone per il drawer personalizzabile con icona, testo e pagina di destinazione
  const ButtonNoAnimatedTr({
    super.key,
    required this.testo,
  });
  final String testo;

  @override
  State<ButtonNoAnimatedTr> createState() => _ButtonNoAnimatedTrState();
}

class _ButtonNoAnimatedTrState extends State<ButtonNoAnimatedTr> {
  bool value = false; // Stato iniziale del switch

  @override
  // void initState() {
  //   super.initState();
  //   _loadPreference(); // Carica lo stato salvato
  // }

  // Future<void> _loadPreference() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     value = prefs.getBool('switchState_${widget.testo}') ?? false;
  //   });
  // }

  // Future<void> _savePreference(bool newValue) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('switchState_${widget.testo}', newValue);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: value
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.circularBorder,
        ),
        child: InkWell(
          borderRadius: AppRadius.circularBorder,
          onTap: () {
            setState(() {
              value = !value;
              // _savePreference(value); // Salva lo stato aggiornato
            });
          },
          child: Row(
            children: [
              const SizedBox(width: 16),
              const SizedBox(width: 8),
              Text(
                '${widget.testo}  ',
                style: TextStyle(
                    color: value
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary),
              ),
              const Spacer(),
              Switch(
                value: value,
                onChanged: (bool newValue) {
                  setState(() {
                    value = newValue;
                    // _savePreference(newValue); // Salva lo stato aggiornato
                  });
                },
                activeColor: Colors.deepPurple[200],
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
