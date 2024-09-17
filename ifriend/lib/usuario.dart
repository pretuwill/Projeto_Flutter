class Usuario {
  final String nome;
  final String email;
  final String senha;

  Usuario({required this.nome, required this.email, required this.senha});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  static Usuario fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }
}
