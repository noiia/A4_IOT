import 'package:flutter/material.dart';

class StudentRowItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final bool isPresent; // Booléen pour gérer l'état facilement

  const StudentRowItem({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.isPresent,
  });

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs selon le statut
    final statusColor = isPresent ? Colors.green : Colors.red;
    final statusText = isPresent ? "Présent" : "Absent";
    final statusIcon = isPresent ? Icons.check_circle : Icons.cancel;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Petite bordure colorée pour accentuer l'état
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- GAUCHE : Avatar + Nom ---
          CircleAvatar(
            radius: 20, // Plus petit que la card précédente
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // --- DROITE : Statut avec accent ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1), // Fond léger vert ou rouge
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, color: statusColor, size: 16),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
