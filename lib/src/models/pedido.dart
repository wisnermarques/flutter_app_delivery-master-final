class Pedido {
  final int id;
  final String status;
  final DateTime dataPedido;

  Pedido({
    required this.id,
    required this.status,
    required this.dataPedido,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      status: json['attributes']['status'],
      dataPedido: DateTime.parse(json['attributes']['createdAt']),
    );
  }
}
