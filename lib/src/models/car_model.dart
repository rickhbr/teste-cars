class Car {
  final int id;
  final String nomeModelo;
  final int ano;
  final String combustivel;
  final int numPortas;
  final String cor;
  final double valor;

  Car({
    required this.id,
    required this.nomeModelo,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.valor,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int? ?? 0,
      nomeModelo: json['nome_modelo'] as String? ?? '',
      ano: json['ano'] as int? ?? 0,
      combustivel: json['combustivel'] as String? ?? '',
      numPortas: json['num_portas'] as int? ?? 0,
      cor: json['cor'] as String? ?? '',
      valor: (json['valor'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome_modelo': nomeModelo,
        'ano': ano,
        'combustivel': combustivel,
        'num_portas': numPortas,
        'cor': cor,
        'valor': valor,
      };
}
