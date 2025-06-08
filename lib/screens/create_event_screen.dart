import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:festymap/screens/event_created_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:festymap/providers/event_provider.dart';
import 'package:festymap/models/event_model.dart';

class CrearEventoScreen extends StatefulWidget {
  @override
  _CrearEventoScreenState createState() => _CrearEventoScreenState();
}

class _CrearEventoScreenState extends State<CrearEventoScreen> {
  final MapController _mapController = MapController();
  LatLng _selectedLocation = LatLng(19.4326, -99.1332); // CDMX

  // Controladores
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _calleController = TextEditingController();
  final _numeroController = TextEditingController();
  final _ciudadController = TextEditingController();
  final _estadoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();

  final List<String> _imagenesEventos = [
    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjX_1UmOuQ-9EsN3st7-O7ZfP3bePJfPjgQo7RL3_m0eBFZiciz4d8W8eXN0YnLKGp-XjtHw-2pubFH0eClOxT4hwJktowGE1O2NW2z2CIz8Td7wzn9Ao2uUIL4-UxLZA_6oJydpnEl-ybp/s1600/neon-party-fiesta-decoracion-uv-14.jpg",
    "https://i2.wp.com/lostinanime.com/wp-content/uploads/2018/01/Devilman-Crybaby-01-27.jpg?w=780",
    "https://cdn2.actitudfem.com/media/files/styles/gallerie_carousel/public/images/2018/01/fiestaneon.jpg",
    "https://www.creativefabrica.com/wp-content/uploads/2020/02/09/Neon-party-flyer-template-Graphics-1-1.jpg"
  ];

  // Función segura para obtener partes de la fecha
  String _getFechaPart(int index) {
    final parts = _fechaController.text.split('/');
    if (parts.length > index) {
      return parts[index];
    }
    return _fechaController
        .text; // Devuelve el texto completo si no se puede dividir
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final random = Random();

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Crear nuevo evento",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF00FF),
                      shadows: [
                        Shadow(
                          color: Colors.white.withOpacity(0.5),
                          offset: const Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("Nombre del evento", "Ej: Fiesta de verano",
                    controller: _nombreController),
                _buildTextField(
                    "Descripción", "Escribe los detalles del evento...",
                    controller: _descripcionController),
                _buildTextField("Calle", "Ej: Av. Reforma",
                    controller: _calleController),
                _buildTextField("Número", "Ej: 123",
                    controller: _numeroController),
                _buildTextField("Ciudad", "Ej: CDMX",
                    controller: _ciudadController),
                _buildTextField("Estado", "Ej: Ciudad de México",
                    controller: _estadoController),
                _buildTextField("Fecha", "dd/mm/aaaa",
                    controller: _fechaController),
                _buildTextField("Hora", "--:--", controller: _horaController),
                const SizedBox(height: 10),
                Text(
                  "Subir imagen del evento:",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C3FF),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Seleccionar archivo",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Mapa del evento:",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _selectedLocation,
                        zoom: 13.0,
                        onTap: (tapPosition, point) {
                          setState(() {
                            _selectedLocation = point;
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.festymap',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _selectedLocation,
                              width: 40,
                              height: 40,
                              builder: (ctx) => const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      backgroundColor: const Color(0xFF10EFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Validación básica
                      if (_nombreController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Por favor ingresa un nombre para el evento")));
                        return;
                      }

                      // Crear nuevo evento con manejo seguro de fecha
                      final nuevoEvento = Event(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        titulo: _nombreController.text,
                        lugar:
                            "${_ciudadController.text} - ${_getFechaPart(0)}/${_getFechaPart(1)}",
                        imagen: _imagenesEventos[
                            random.nextInt(_imagenesEventos.length)],
                        calle: _calleController.text,
                        numero: _numeroController.text,
                        ciudad: _ciudadController.text,
                        estado: _estadoController.text,
                        fecha: _fechaController.text,
                        hora: _horaController.text,
                        latitud: _selectedLocation.latitude,
                        longitud: _selectedLocation.longitude,
                      );

                      eventProvider.agregarEvento(nuevoEvento);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventoCreadoScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Crear evento",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
