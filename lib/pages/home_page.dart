import 'package:flutter/material.dart';
import 'package:a4_iot/widget/profile_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return _mobileLayout();
          } else {
            return _desktopLayout();
          }
        },
      ),
    );
  }

  Widget _mobileLayout() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 500,
            child: ProfileCard(
              firstName: "Edwin",
              lastName: "Lecomte",
              status: "Etudiant",
              proms: "FISA A4",
              campus: "Reims",
              avatarUrl: "https://i.pravatar.cc/300",
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return const Center(
      child: SizedBox(
        width: 500,
        child: ProfileCard(
          firstName: "Edwin",
          lastName: "Lecomte",
          status: "Etudiant",
          proms: "FISA A4",
          campus: "Reims",
          avatarUrl: "https://i.pravatar.cc/300",
        ),
      ),
    );
  }
}
