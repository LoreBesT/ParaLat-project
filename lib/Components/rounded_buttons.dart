import 'package:flutter/material.dart';

class RoundedButtons extends StatefulWidget {
  final String testo;
  final IconData icon;
  final dynamic function;
  final Color iconColor;
  const RoundedButtons({
    super.key,
    required this.testo,
    required this.icon,
    required this.function,
    required this.iconColor,
  });

  @override
  State<RoundedButtons> createState() => _RoundedButtonsState();
}

class _RoundedButtonsState extends State<RoundedButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 160,
        width: 160,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.function,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.testo,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Icon(
                  widget.icon,
                  size: 50,
                  color: widget.iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
