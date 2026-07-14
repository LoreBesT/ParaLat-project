import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';

class RoundedButtonsNew extends StatefulWidget {
  final String testo;
  final IconData icon;
  final dynamic function;
  final bool page;
  const RoundedButtonsNew({
    super.key,
    required this.testo,
    required this.icon,
    required this.function,
    required this.page,
  });

  @override
  State<RoundedButtonsNew> createState() => _RoundedButtonsNewState();
}

class _RoundedButtonsNewState extends State<RoundedButtonsNew> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.circularBorder),
        child: InkWell(
          onTap: () {
            if (widget.page == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.function,
                ),
              );
            } else {
              widget.function();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.testo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
