import 'package:flutter/material.dart';

class GirisSayfasi extends StatelessWidget {
  const GirisSayfasi({super.key});
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/giris2.png',
              width: 200,
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sudoku');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              child: const Text('Başla'),
            ),
          ],
        ),
      ),
    );
  }
}
