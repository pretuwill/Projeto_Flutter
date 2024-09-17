import 'usuario.dart';

class UsuarioService {
  static final List<Usuario> _usuarios = [];

  static void adicionarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  static Usuario? autenticar(String email, String senha) {
    for (var usuario in _usuarios) {
      if (usuario.email == email && usuario.senha == senha) {
        return usuario;
      }
    }
    return null;
  }

  static List<Usuario> get usuarios => _usuarios;
}
