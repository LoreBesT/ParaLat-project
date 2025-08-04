import 'package:flutter/material.dart';

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              SizedBox(
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
