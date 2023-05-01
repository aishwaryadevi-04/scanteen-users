import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCategory extends StatelessWidget {
  const FoodCategory({super.key});

  @override
  Widget build(BuildContext context) {
     List<String> types = ['Snacks', 'Drinks', 'Lunch', 'Icecream'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: types.map((entry) {
          String key = entry;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE09145),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(90, 30),
                ),
                child: Text(
                  key,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Color(0XFF17181D),
                    ),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 15)
            ],
          );
        }).toList(),
      ),
    );
  }
}
