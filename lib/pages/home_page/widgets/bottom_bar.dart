import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final PageController controller;
  const BottomBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 20,
      left: size.width / 6,
      right: size.width / 6,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: const Color(0XFF2b2e3d).withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            IconButton(
              iconSize: 28,
              splashRadius: 25,
              icon: const Icon(
              Icons.qr_code_scanner_outlined,
              color: Colors.white,
              ),
              onPressed: () => controller.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              ),
            ),
            IconButton(
              iconSize: 28,
              splashRadius: 25,
              icon: const Icon(
              Icons.home,
              color: Colors.white,
              ),
              onPressed: () => controller.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              ),
            ),
            IconButton(
              iconSize: 28,
              splashRadius: 25,
              icon: const Icon(
              Icons.settings,
              color: Colors.white,
              ),
              onPressed: () => controller.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
