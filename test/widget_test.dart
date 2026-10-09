import 'package:flutter_test/flutter_test.dart';
import 'package:loopbreak/main.dart';

void main() {
  testWidgets('LoopBreak dashboard loads', (tester) async {
    await tester.pumpWidget(const LoopBreakApp());

    expect(find.text('LoopBreak'), findsOneWidget);
    expect(find.text('Break the pattern.'), findsOneWidget);
    expect(find.text('Recent mistakes'), findsOneWidget);
  });
}
