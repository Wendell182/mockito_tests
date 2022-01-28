import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito_test/routes/routes.dart';

import 'routes_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      as: #MockNavigatorObserver,
      returnNullOnMissingStub: true,
    ),
  ],
)
void main() {
  final navigatorObserver = MockNavigatorObserver();

  testWidgets('Verificar se o push da primeira pagina foi executado',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorObservers: [navigatorObserver],
    ));

    expect(
      verify(
        navigatorObserver.didPush(captureAny, any),
      ).captured.single,
      (Route r) => r.settings.name == '/',
    );
  });

  testWidgets('Validar o push da tela inicial para SecondPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorObservers: [navigatorObserver],
    ));

    await tester.tap(find.text('PUSH'));

    expect(
      verify(
        navigatorObserver.didPush(captureAny, any),
      ).captured[1],
      (Route r) => r.settings.name == '/second',
    );
  });

  testWidgets('Teste do pop da SecondPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorObservers: [navigatorObserver],
    ));

    await tester.tap(find.text('PUSH'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('POP'));

    expect(
      verify(
        navigatorObserver.didPop(captureAny, any),
      ).captured.single,
      (Route r) => r.settings.name == '/second',
    );
  });

  testWidgets('Teste navegaçao de troca de tela que esta na pilha ',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorObservers: [navigatorObserver],
    ));

    await tester.tap(find.text('REPLACE'));

    expect(
      verify(
        navigatorObserver.didReplace(
          newRoute: captureAnyNamed('newRoute'),
          oldRoute: anyNamed('oldRoute'),
        ),
      ).captured.single,
      (Route r) => r.settings.name == '/second',
    );
  });
}
