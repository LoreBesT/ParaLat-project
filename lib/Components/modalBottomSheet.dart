import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
void showNumberPickerBottomSheet(BuildContext context,
    {required ValueChanged<int> onNumberSelected}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      int selectedValue = 1; // Valore iniziale del selettore

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Scegli un livello',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Slider(
                  value: selectedValue.toDouble(),
                  min: 0,
                  max: 4,
                  divisions: 4, // Intervalli tra 1 e 4
                  label: selectedValue.toString(),
                  onChanged: (double value) {
                    setState(() {
                      selectedValue = value.toInt();
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    onNumberSelected(selectedValue);
                    Navigator.pop(context); // Chiudi la BottomSheet
                  },
                  child: Text('Conferma'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showCustomBottomSheet(BuildContext context, List<String> buttonLabels) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buttonLabels.map((label) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showNumberPickerBottomSheet(context,
                                          onNumberSelected: (int number) {
                                        String label2 = label
                                            .split(' ')
                                            .first
                                            .toLowerCase();
                                        Auth().addSanction(
                                            label2, "merito", number);
                                      });
                                    },
                                    child: Text("Premio di Merito"),
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showNumberPickerBottomSheet(context,
                                          onNumberSelected: (int number) {
                                        String label2 = label
                                            .split(' ')
                                            .first
                                            .toLowerCase();
                                        Auth().addSanction(
                                            label2, "sanzione", number);
                                      });
                                    },
                                    child: Text("Sanzione"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(label),
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}
