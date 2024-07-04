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
    },
  ));

      // Realiza login
      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Dados"))); 
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Amigos")));
      await _pumpAndSettleWithDelay(tester);

      expect(find.byType(FriendPage), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Marco Tulio');
      await _pumpAndSettleWithDelay(tester);
      await tester.tap(find.byKey(Key('EnviarPedido')));
      await _pumpAndSettleWithDelay(tester);

      expect(find.text('Pedido enviado com sucesso!'), findsOneWidget);
    });

    testWidgets('Accept a friend request', (WidgetTester tester) async {
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

      await tester.enterText(find.byType(TextFormField).at(0), 'marco@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Dados"))); 
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Amigos")));
      await _pumpAndSettleWithDelay(tester);

      expect(find.byType(FriendPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.check).first);
      await _pumpAndSettleWithDelay(tester);

      expect(find.text('Pedido aceito com sucesso!'), findsOneWidget);
    });

  //   testWidgets('Reject a friend request', (WidgetTester tester) async {
  //     await tester.pumpWidget(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: LoginScreen(),
  //   routes: {
  //     '/dados': (context) => PaginaDados(),
  //     '/loja': (context) => PaginaLoja(),
  //     '/biblioteca':(context) => GameLibraryPage(),
  //     '/amigos':(context) => FriendPage(),
  //   },
  // ));

  //     await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
  //     await tester.enterText(find.byType(TextFormField).at(1), '123456');
  //     await tester.tap(find.byType(ElevatedButton));
  //     await _pumpAndSettleWithDelay(tester);

  //     await tester.tap(find.byKey(Key("Dados"))); 
  //     await _pumpAndSettleWithDelay(tester);

  //     await tester.tap(find.byKey(Key("Amigos")));
  //     await _pumpAndSettleWithDelay(tester);

  //     expect(find.byType(FriendPage), findsOneWidget);

  //     await tester.tap(find.byIcon(Icons.close).first);
  //     await _pumpAndSettleWithDelay(tester);

  //     expect(find.text('Pedido rejeitado com sucesso!'), findsOneWidget);
  //   });

    testWidgets('Remove a friend', (WidgetTester tester) async {
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
      await tester.enterText(find.byType(TextFormField).at(0), 'marco@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await _pumpAndSettleWithDelay(tester);

      // Navega para a página de dados
      await tester.tap(find.byKey(Key("Dados")));
      await _pumpAndSettleWithDelay(tester);

      await tester.tap(find.byKey(Key("Amigos")));
      await _pumpAndSettleWithDelay(tester);

      expect(find.byType(FriendPage), findsOneWidget);

      await _pumpAndSettleWithDelay(tester);
      await tester.tap(find.byIcon(Icons.more_vert).first);
      await _pumpAndSettleWithDelay(tester);
      await tester.tap(find.text('Desfazer amizade').first);
      await _pumpAndSettleWithDelay(tester);

      expect(find.text('Amizade excluída'), findsOneWidget);
    });
  });
}
