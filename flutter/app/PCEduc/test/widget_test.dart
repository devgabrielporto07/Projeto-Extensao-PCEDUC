import 'package:flutter_test/flutter_test.dart';

import 'package:pceduc/main.dart';

void main() {
  testWidgets('exibe a tela inicial do PCEDUC', (WidgetTester tester) async {
    await tester.pumpWidget(const PcEducApp());

    expect(find.text('Aprenda hardware jogando'), findsOneWidget);
  });
}
