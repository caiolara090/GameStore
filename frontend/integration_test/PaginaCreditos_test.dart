import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamestore/PaginaCreditos.dart';
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

  group('FriendPage Integration Test', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    Future<void> _pumpAndSettleWithDelay(WidgetTester tester) async {
      await tester.pumpAndSettle(Duration(seconds: 2));
    }

    testWidgets('Navigate to FriendPage and send a friend request', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    routes: {
      '/dados': (context) => PaginaDados(),
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
      '/amigos':(context) => FriendPage(),
      '/creditos':(context) => AddCreditsScreen()
    },
  ));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Dados"))); 
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Creditos")));
      await _pumpAndSettleWithDelay(tester);
      await tester.enterText(find.byType(TextFormField).at(0), 'Maria');
      await tester.enterText(find.byType(TextFormField).at(1), '200');
      await tester.enterText(find.byType(TextFormField).at(2), '1111 2222 3333 4444');
      await tester.enterText(find.byType(TextFormField).at(3), '12/36');
      await tester.enterText(find.byType(TextFormField).at(4), '567');
      await tester.pumpAndSettle(Duration(seconds: 4));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(seconds: 4));
      await tester.tap(find.byType(IconButton).first);
      await _pumpAndSettleWithDelay(tester);
      await tester.tap(find.byKey(Key("Loja")));
      await _pumpAndSettleWithDelay(tester);
      await tester.pumpAndSettle(Duration(seconds: 4));
    });

    
  });
}
