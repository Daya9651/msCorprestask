import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.close, color: Colors.white),
                //   onPressed: () {
                //     remove();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
