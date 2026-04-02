import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';

class ImpostazioniPage2 extends StatefulWidget {
  const ImpostazioniPage2({super.key});

  @override
  State<ImpostazioniPage2> createState() => _ImpostazioniPage2State();
}

class _ImpostazioniPage2State extends State<ImpostazioniPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding : EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.circularBorder,
                ),
                tileColor: AppColors.cardTile,
                leading:  CircleAvatar(child: Text(Verify().nameUser(4), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)), radius: 30, backgroundColor: AppColors.gradientStart),
                title: Text(Verify().nameUser(3), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),),
                subtitle: Text(Auth().getEmail() ?? 'No email', style: TextStyle(fontSize: 12, color: AppColors.gradientStart),),
              ),
              SizedBox(height: 20,),
              DesignSettings().sectionTile(title: "Notifiche Personali", icon: Icons.notifications_outlined,badgeCount: 4),
            ]
          ),
        ),
      ),
    );
  }
}