import 'package:app/utils/sync_service.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScannerSyncPage extends StatefulWidget {
  final PageController controller;
  const ScannerSyncPage({
    super.key,
    required this.controller,
  });

  @override
  State<ScannerSyncPage> createState() => _ScannerSyncPageState();
}

class _ScannerSyncPageState extends State<ScannerSyncPage> {
  bool stanbay = false;

  Future _connect({String? jwt, BuildContext? context}) async {
    if (jwt == null) return;

    try {
      await Vibration.vibrate(duration: 150);
    } catch (_) {}

    print('[SCANNER] JWT escaneado: ${jwt.substring(0, 30)}...');

    try {
      // Conectar via WebSocket al Desktop
      await SyncService().connect(jwt);
      print('[SCANNER] Conexión WS exitosa');
    } catch (e) {
      print('[SCANNER] Error conectando WS: $e');
      Fluttertoast.showToast(
        msg: "Error al conectar: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() => stanbay = false);
      return;
    }

    widget.controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      stanbay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        stanbay
            ? Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(const Color(detalles)),
                    ),
                  ),
                ),
              )
            : MobileScanner(
                onDetect: (capture) async {
                  final barcode = capture.barcodes.firstOrNull;
                  if (barcode?.rawValue != null) {
                    setState(() {
                      stanbay = true;
                    });
                    await _connect(jwt: barcode!.rawValue, context: context);
                  }
                },
              )
      ],
    );
  }
}
