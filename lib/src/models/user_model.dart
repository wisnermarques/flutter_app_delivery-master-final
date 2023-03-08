import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = true;

  late dynamic userLogado = '';

  late dynamic itensCarrinho = [];

  late dynamic dadosPedido = [];

  late dynamic meuPedido = [];

  late dynamic meusPedidos = [];

  late dynamic pagamento = '';

  double subtotal = 0;

  late int idCliente = 0;

  loginUser({required String email, required String password}) async {
    var data = {'identifier': email, 'password': password};
    await http
        .post(
      Uri.parse('https://apidelivery-production.up.railway.app/api/auth/local'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    )
        .then((response) async {
      if (response.statusCode == 200) {
        isLoading = false;

        userLogado = jsonDecode(response.body);
        notifyListeners();

        Uri url = Uri.https('apidelivery-production.up.railway.app',
            'api/users/${userLogado['user']['id']}', {'populate': '*'});

        await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${userLogado['jwt']}',
          },
        ).then((userCliente) {
          var dados = json.decode(userCliente.body);
          idCliente = dados['cliente']['id'];

          notifyListeners();
        });
      } else if (response.statusCode == 400) {
        isLoading = false;

        notifyListeners();
      }
    });
  }

  bool isLoggedIn() {
    return userLogado != '';
  }

  signOut() {
    userLogado = '';
    meusPedidos = [];
    isLoading = false;
    notifyListeners();
  }

  // Cria usuário
  createUser(
      {required String username,
      required String email,
      required String endereco,
      required String telefone,
      required String password,
      required String nome}) {
    nome = username;

    //Salva dados do cliente
    var data = {
      "data": {
        'nome': nome,
        'endereco': endereco,
        'telefone': telefone,
      }
    };

    http
        .post(
      Uri.parse('https://apidelivery-production.up.railway.app/api/clientes'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var listResponse = jsonDecode(response.body);

        notifyListeners();
        var data = {
          'username': username,
          'email': email,
          'password': password,
          'role': 1,
          'cliente': listResponse['data']['id']
        };
        http
            .post(
          Uri.parse(
              'https://apidelivery-production.up.railway.app/api/auth/local/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        )
            .then((response) {
          if (response.statusCode == 200) {
            isLoading = false;
            notifyListeners();
            userLogado = jsonDecode(response.body);
          } else {
            throw Exception('Failed to create user.');
          }
        });
      } else {
        isLoading = false;
        notifyListeners();
        throw Exception('Failed to create user.');
      }
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      throw Exception('Failed to create user.');
    });
  }

  addCarrinho(idProduto, nome, valor, imagem) {
    late dynamic item = {};
    item['nome'] = nome;
    item['valor'] = valor;
    item['imagem'] = imagem;
    item['quantidade'] = 1;
    itensCarrinho.add(item);

    late dynamic itemPedido = {};

    itemPedido['quantidade'] = 1;
    itemPedido['produto'] = idProduto;
    dadosPedido.add(itemPedido);

    notifyListeners();
  }

  updateCarrinho(index, quantidade) {
    itensCarrinho[index]['quantidade'] = quantidade;
    dadosPedido[index]['quantidade'] = quantidade;
    notifyListeners();
  }

  finalizarCompra() {
    var data = {
      "data": {
        'dadosPedido': dadosPedido,
        'cliente': idCliente,
        'pagamento': pagamento
      }
    };
    //print(data);
    http
        .post(
      Uri.parse('https://apidelivery-production.up.railway.app/api/pedidos'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userLogado['jwt']}',
      },
      body: jsonEncode(data),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var dadosPedido = jsonDecode(response.body);
        var id = dadosPedido['data']['id'];
        http
            .get(Uri.parse(
                'https://apidelivery-production.up.railway.app/api/pedidos/$id?populate[dadosPedido][populate]=*'))
            .then((response) {
          if (response.statusCode == 200) {
            meuPedido = jsonDecode(response.body);
            itensCarrinho.clear();
            notifyListeners();
          }
        });
      } else {
        //print(response.body);
        throw Exception('erro ao finalizar a compra');
      }
    }).catchError((erro) => throw Exception(erro));
  }

  listaPedidosCliente() async {
    if (isLoggedIn() && idCliente > 0) {
      await http
          .get(Uri.parse(
              'https://apidelivery-production.up.railway.app/api/clientes/$idCliente?populate[pedidos][populate]=*'))
          .then((response) {
        if (response.statusCode == 200) {
          meusPedidos = jsonDecode(response.body);

          notifyListeners();
        } else {
          throw Exception('erro ao carregar pedidos');
        }
      });
    }
  }
}
