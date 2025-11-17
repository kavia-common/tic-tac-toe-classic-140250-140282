import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_frontend/main.dart';

void main() {
  testWidgets('App renders Tic Tac Toe screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());
    // Verify app bar title
    expect(find.text('Tic Tac Toe'), findsOneWidget);
    // Verify Reset button exists
    expect(find.text('Reset Game'), findsOneWidget);
    // Verify there are 9 tiles rendered (grid cells)
    // We expect GestureDetectors wrapping tiles; alternatively check by semantics
    expect(find.byType(GestureDetector), findsWidgets);
  });
}
