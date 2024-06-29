import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gamestore/PaginaCadastro.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RegistrationScreen E2E Tests', () {
    testWidgets('Should display error messages when fields are empty', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegistrationScreen()));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Campo não pode estar vazio'), findsAtLeastNWidgets(2));
      expect(find.text('Digite a idade'), findsOneWidget);
    });

    testWidgets('Should display error message for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegistrationScreen()));

      await tester.enterText(find.byKey(Key("nomeField")), 'Teste Nome');
      await tester.enterText(find.byKey(Key("idadeField")), '20');
      await tester.enterText(find.byKey(Key("e-mailField")), 'teste email invalido');
      await tester.enterText(find.byKey(Key("senhaField")), 'Testesenha');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));

      expect(find.text('Digite um e-mail válido'), findsOneWidget);
    });

    testWidgets('Should display error message for short password', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegistrationScreen()));

      await tester.enterText(find.byType(TextFormField).at(0), 'Teste Nome');
      await tester.enterText(find.byType(TextFormField).at(1), '20');
      await tester.enterText(find.byType(TextFormField).at(2), 'teste@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(3), '123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));

      expect(find.text('A senha deve ter pelo menos 6 caracteres'), findsOneWidget);
    });

    testWidgets('Should show success message on valid form submission', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegistrationScreen()));

      String nomeuser = "Testeaaa";
      String email = "emailtesteaa" + "@hotmail.com";

      await tester.enterText(find.byType(TextFormField).at(0), nomeuser);
      await tester.enterText(find.byType(TextFormField).at(1), '20');
      await tester.enterText(find.byType(TextFormField).at(2), email);
      await tester.enterText(find.byType(TextFormField).at(3), 'Testesenha');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byType(ElevatedButton));

      expect(find.text('Registro bem-sucedido para $nomeuser!'), findsOneWidget);
    });
  });
}
