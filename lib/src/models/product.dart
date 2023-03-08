class Product {
  int id;
  String nome;
  String imagem;
  //String categoria;
  String valor;
  int desconto;
  int avaliacoes;

  Product(
    this.id,
    this.nome,
    this.imagem,
    //this.categoria,
    this.valor,
    this.desconto,
    this.avaliacoes,
  );

  factory Product.fromJson(dynamic json) {
    return Product(
      json['id'] as int,
      json['attributes']['nome'] as String,
      json['attributes']['imagem']['data']['attributes']['formats']['thumbnail']
          ['url'] as String,
      json['attributes']['valor'] as String,
      json['attributes']['desconto'] as int,
      json['attributes']['avaliacoes'] as int,
    );
  }
}
