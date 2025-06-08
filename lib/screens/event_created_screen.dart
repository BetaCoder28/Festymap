import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventoCreadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF451157), Color(0xFF11435D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¡Evento creado con éxito!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00FFFF),
                      shadows: [
                        Shadow(
                          color: Colors.white.withOpacity(0.5),
                          offset: const Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.check_circle,
                      color: Color(0xFF00FFFF), size: 80),
                  const SizedBox(height: 20),
                  Text(
                    "Tu evento ha sido publicado y ahora aparecerá en el mapa y en la lista de eventos.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 30),
                      backgroundColor: const Color(0xFFE11EFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      // Regresa a la pantalla principal o donde quieras
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text(
                      "Volver al inicio",
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
