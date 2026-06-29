import 'package:app/utils/sync_service.dart';
import 'package:flutter/material.dart';

/// Banner verde que aparece en la parte superior cuando hay conexión WebSocket activa.
/// Al presionar, cierra la conexión.
class SyncBanner extends StatelessWidget {
  const SyncBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final sync = SyncService();

    return StreamBuilder<bool>(
      stream: sync.onConnectionChanged,
      initialData: sync.isConnected,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? false;
        if (!isConnected) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0XFF2CDA9D).withOpacity(0.15),
            border: Border(
              bottom: BorderSide(
                color: const Color(0XFF2CDA9D).withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () => sync.disconnect(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.link,
                  color: const Color(0XFF2CDA9D),
                  size: 16,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Desktop conectado',
                  style: TextStyle(
                    color: Color(0XFF2CDA9D),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.close,
                  color: const Color(0XFF2CDA9D).withOpacity(0.6),
                  size: 14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
