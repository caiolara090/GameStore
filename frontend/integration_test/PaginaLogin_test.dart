import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamestore/PaginaLogin.dart';
import 'package:gamestore/PaginaLoja.dart';

void main() {
  group('LoginScreen', () {
    setUp(() async {
      // Certifique-se de limpar as SharedPreferences antes de cada teste
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders LoginScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('shows error message when email is invalid', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'invalid email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Digite um e-mail válido'), findsOneWidget);
    });

    testWidgets('shows error message when password is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Digite a senha'), findsOneWidget);
    });

    testWidgets('navigates to PaginaLoja on successful login', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Dê tempo suficiente para a resposta HTTP
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(PaginaLoja), findsOneWidget);
    });

    testWidgets('shows error message on failed login', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'wrong@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Dê tempo suficiente para a resposta HTTP
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('Falha no login. Por favor, verifique suas credenciais.'), findsOneWidget);
    });
  });
}
