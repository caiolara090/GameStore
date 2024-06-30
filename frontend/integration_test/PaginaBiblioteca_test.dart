import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamestore/main.dart';
import 'package:gamestore/PaginaLogin.dart';
import 'package:gamestore/PaginaLoja.dart';
import 'package:gamestore/PaginaBiblioteca.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Realiza login e navega para a página da loja', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(),
      routes: {
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
    },));

      // Insere os dados de login e submete o formulário
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));

      // Aguarda a navegação para a PáginaLoja
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Verifica se a PáginaLoja é exibida
      expect(find.byType(PaginaLoja), findsOneWidget);
    });

    testWidgets('Navega para a biblioteca de jogos', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(),
      routes: {
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
    },));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Toca no botão da biblioteca na BottomNavigationBar
      await tester.tap(find.byKey(Key("Biblioteca")));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Verifica se a GameLibraryPage é exibida
      expect(find.byType(GameLibraryPage), findsOneWidget);
    });

    testWidgets('Pesquisa por jogos na biblioteca', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(),
      routes: {
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
    },));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Navega para a biblioteca
      await tester.tap(find.byKey(Key("Biblioteca")));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Realiza uma pesquisa de jogo
      await tester.enterText(find.byType(TextField), 'Sid Meier\'s Alpha Centauri');
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Verifica se o jogo pesquisado aparece na lista
      expect(find.text('Sid Meier\'s Alpha Centauri'), findsWidgets);
    });

    testWidgets('Favorita um jogo', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(),
      routes: {
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
    },));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Navega para a biblioteca
      await tester.tap(find.byKey(Key("Biblioteca")));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Realiza uma pesquisa de jogo
      await tester.enterText(find.byType(TextField), 'a');
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Favorita um jogo
      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      // Verifica se o jogo foi adicionado aos favoritos
      expect(find.byIcon(Icons.star), findsWidgets);
    });
  });
}
