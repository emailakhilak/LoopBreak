import 'package:flutter_test/flutter_test.dart';
import 'package:loopbreak/main.dart';

void main() {
  testWidgets('LoopBreak dashboard displays mistakes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LoopBreakApp());

    expect(find.text('LoopBreak'), findsOneWidget);
    expect(find.text('Break the pattern.'), findsOneWidget);
    expect(find.text('Recent mistakes'), findsOneWidget);
    expect(find.text('Started assignment too late'), findsOneWidget);
    expect(find.text('Forgot to test my code'), findsOneWidget);
  });
}
