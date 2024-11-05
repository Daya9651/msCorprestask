import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key,
    required this.title,
    required this.onTap,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):Text(title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),),
        ),
      ),
    );
  }
}
