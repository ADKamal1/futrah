import 'package:flutter/material.dart';
import 'package:futrah/view/widgets/my_text.dart';

Widget get sDiv => Container(width: 2, height: 30, color: Colors.black);

class BillTable extends StatelessWidget {
  final String billKey, value;

  const BillTable({super.key, required this.billKey, required this.value});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: size,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size / 3,
            child: Center(
              child: FittedBox(
                child: MyText(
                  title: billKey,
                  alien: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          sDiv,
          SizedBox(
            width: size / 3,
            child: Center(
              child: FittedBox(
                child: MyText(
                  title: value,
                  alien: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
