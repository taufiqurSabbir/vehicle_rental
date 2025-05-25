import 'package:flutter/material.dart';

class VechicleTitle extends StatelessWidget {
  final String title,value;
  const VechicleTitle({
    super.key, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Text(value,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400
          ),)
        ],
      ),
    );
  }
}
