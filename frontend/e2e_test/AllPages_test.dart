import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gamestore/PaginaCadastro.dart';
import 'package:gamestore/PaginaBiblioteca.dart';
import 'package:gamestore/PaginaDados.dart';
import 'package:gamestore/PaginaLoja.dart';
import 'package:gamestore/PaginaAmigos.dart';
import 'package:gamestore/PaginaLogin.dart';
import 'package:gamestore/PaginaCreditos.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetController.hitTestWarningShouldBeFatal;

  group('E2E Test', () {

    testWidgets('Should show success message on valid form submission', (WidgetTester tester) async {
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

      // Testa o Cadastro

      String nomeuser = "Marcia Teste";
      String email = "marciateste" + "@hotmail.com";

      await tester.enterText(find.byType(TextFormField).at(0), nomeuser);
      await tester.enterText(find.byType(TextFormField).at(1), '20');
      await tester.enterText(find.byType(TextFormField).at(2), email);
      await tester.enterText(find.byType(TextFormField).at(3), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(Key("Botao")));
      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(find.text('Registro bem-sucedido para $nomeuser!'), findsOneWidget);

      // Testa o login

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.enterText(find.byType(TextFormField).at(0), 'caio@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(find.byType(PaginaLoja), findsOneWidget);

      // Testa adicionar créditos

      await tester.tap(find.byKey(Key("Dados")), warnIfMissed: false);
      await tester.pumpAndSettle(Duration(seconds: 2)); 

      await tester.tap(find.byKey(Key("Creditos")), warnIfMissed: false);
      await tester.enterText(find.byType(TextFormField).at(0), 'Marta');
      await tester.enterText(find.byType(TextFormField).at(1), '300');
      await tester.enterText(find.byType(TextFormField).at(2), '1111 2222 3333 4444');
      await tester.enterText(find.byType(TextFormField).at(3), '12/26');
      await tester.enterText(find.byType(TextFormField).at(4), '567');
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byType(IconButton).first, warnIfMissed: false);
      await tester.tap(find.byKey(Key("Loja")), warnIfMissed: false);
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Testa comprar jogo

      // Testa favoritar jogo

      await tester.tap(find.byKey(Key("Biblioteca")));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pumpAndSettle(Duration(milliseconds: 3000));

      expect(find.byIcon(Icons.star), findsWidgets);

      // Testa desfavoritar um jogo

      await tester.tap(find.byIcon(Icons.star).first);
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      expect(find.byIcon(Icons.star), findsNothing);

      // Testa enviar pedido de amizade

      await tester.tap(find.byKey(Key("Dados"))); 
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      await tester.tap(find.byKey(Key("Amigos")));
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      expect(find.byType(FriendPage), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Marco Tulio');
      await tester.pumpAndSettle(Duration(milliseconds: 2000));
      await tester.tap(find.byKey(Key('EnviarPedido')));
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      expect(find.text('Pedido enviado com sucesso!'), findsOneWidget);

      // Testa aceitar o pedido de amizade

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.tap(find.byKey(Key("Sair"))); 
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      await tester.enterText(find.byType(TextFormField).at(0), 'marco@hotmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      await tester.tap(find.byKey(Key("Dados"))); 
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      await tester.tap(find.byKey(Key("Amigos")));
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      expect(find.byType(FriendPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.check).first);
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      expect(find.text('Pedido aceito com sucesso!'), findsOneWidget);

      // Testa desfazer uma amizade

      await tester.pumpAndSettle(Duration(milliseconds: 2000));
      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle(Duration(milliseconds: 2000));
      await tester.tap(find.text('Desfazer amizade').first);
      await tester.pumpAndSettle(Duration(milliseconds: 2000));

      expect(find.text('Amizade excluída'), findsOneWidget);
      await tester.pumpAndSettle(Duration(milliseconds: 2000));
    });
  });
}
