import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF451157),
            Color(0xFF11435D),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFE11EFF), Color(0xFF10EFFF)],
                    ).createShader(bounds),
                    child: Text(
                      "Crear cuenta",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Nombre de usuario',
                      controller: _usernameController),
                  const SizedBox(height: 10),
                  _buildTextField('Correo electrónico',
                      controller: _emailController),
                  const SizedBox(height: 10),
                  _buildTextField('Contraseña',
                      obscure: true, controller: _passwordController),
                  const SizedBox(height: 10),
                  _buildTextField('Confirmar contraseña',
                      obscure: true, controller: _confirmPasswordController),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        Fluttertoast.showToast(
                          msg: "Las contraseñas no coinciden",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        return;
                      }

                      if (authProvider
                          .isEmailRegistered(_emailController.text)) {
                        Fluttertoast.showToast(
                          msg: "El correo ya está registrado",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        return;
                      }

                      try {
                        await authProvider.register(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Error al registrar: $e",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF10EFFF),
                            Color(0xFFE11EFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "¿Ya tienes una cuenta? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: "Inicia sesión",
                            style: TextStyle(color: Color(0xFF10EFFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildTextField(String hint,
      {bool obscure = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
