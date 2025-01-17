import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, Constraints) {
        return Column(
          children: [
            Container(
              height: Constraints.maxHeight * 0.22,
              child: FittedBox(
                child: Text(
                  'R\$\n${value.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.58,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.10,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
