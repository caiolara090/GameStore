import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamestore/main.dart';
import 'package:gamestore/PaginaLogin.dart';
import 'package:gamestore/PaginaLoja.dart';
import 'package:gamestore/PaginaBiblioteca.dart';
import 'package:gamestore/PaginaAmigos.dart';
import 'package:gamestore/PaginaDados.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PaginaJogo Integration Test', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    Future<void> _pumpAndSettleWithDelay(WidgetTester tester) async {
      await tester.pumpAndSettle(Duration(seconds: 2));
    }
    testWidgets('Navigate to PaginaJogo and buy a game', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/dados': (context) => PaginaDados(),
        '/loja': (context) => PaginaLoja(),
        '/biblioteca': (context) => GameLibraryPage(),
        '/amigos': (context) => FriendPage(),
      },
    ));

    // Realiza login
    await tester.enterText(find.byType(TextFormField).at(0), 'murilo@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await _pumpAndSettleWithDelay(tester);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await _pumpAndSettleWithDelay(tester);
    await _pumpAndSettleWithDelay(tester);
    await tester.tapAt(tester.getCenter(find.byType(MaterialApp)));
    await _pumpAndSettleWithDelay(tester);

    // Rola a tela até o botão "Comprar" estar visível
    await tester.scrollUntilVisible(
      find.byKey(Key('Comprar')),
      500.0,
      scrollable: find.byType(Scrollable).first,
    );

    await _pumpAndSettleWithDelay(tester);
    await tester.tap(find.byKey(Key('Comprar')));
    await _pumpAndSettleWithDelay(tester);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await _pumpAndSettleWithDelay(tester);
    await _pumpAndSettleWithDelay(tester);
  });

  testWidgets('Navigate to PaginaJogo and send a review', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    routes: {
      '/dados': (context) => PaginaDados(),
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
      '/amigos':(context) => FriendPage(),
    },
  ));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);
      //await tester.enterText(find.byType(TextField), 'Sid Meier\'s Alpha Centauri');
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      await _pumpAndSettleWithDelay(tester);
      //await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);
    await tester.tapAt(tester.getCenter(find.byType(MaterialApp)));
    await _pumpAndSettleWithDelay(tester);
    await tester.scrollUntilVisible(
      find.byKey(Key('textFieldKey')),
      500.0,
      scrollable: find.byType(Scrollable).first,
    );
    await _pumpAndSettleWithDelay(tester);
    await tester.enterText(find.byKey(Key('textFieldKey')), 'Jogo Ruim!');
    await _pumpAndSettleWithDelay(tester);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await tester.tap(find.byKey(Key('enviarava')));
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    
    });
    
  });
}