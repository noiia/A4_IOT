import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String status;
  final String proms;
  final String campus;
  final String lastPointing;
  final String avatarUrl;

  const ProfileCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.proms,
    required this.campus,
    required this.lastPointing,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 55, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(height: 20),
            Text(
              "$firstName $lastName",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "$status - $lastPointing",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            Text(
              "$proms - $campus",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
