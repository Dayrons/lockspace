import 'package:app/pages/list_password_page/list_password_page.dart';
import 'package:app/pages/page_scanner_sync/page_scanner_sync.dart';
import 'package:app/pages/settings_page/settings_page.dart';
import 'package:app/pages/home_page/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';


class PaginaInicio extends StatelessWidget {
  final PageController controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            child: PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: [ScannerSyncPage(), ListPasswordPage(), SettingsPage()],
            ),
          ),
          BottomBar(controller: controller,)
         
        ],
      )
          // Replace with your desired widget
          ),
    );
  }
}
