import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

void main() {
  runApp(const MiTiendaFlores());
}

class MiTiendaFlores extends StatelessWidget {
  const MiTiendaFlores({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aura - Florería',
      theme: ThemeData(
        // EDITAR: Color principal del tema
        primaryColor: const Color.fromARGB(255, 193, 154, 245),
      ),
      home: const ProductPage(),
    );
  }
}

/// Widget para las tarjetas de productos
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            "\$$price.00 MXN",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// Widget para los selectores de ubicación/fecha
class SelectorChip extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;

  const SelectorChip({
    super.key,
    required this.iconData,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Hace que ocupe todo el ancho disponible
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color colorLila = Color.fromARGB(255, 193, 154, 245);
    bool esWeb = kIsWeb;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorLila,
        elevation: 0,
        automaticallyImplyLeading: esWeb ? false : true,
        title: Row(
          children: [
            const Text(
              "Aura",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            if (esWeb)
              Expanded(
                child: Container(
                  height: 38,
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "¿Qué regalo tienes en mente?",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      ),
      drawer: esWeb
          ? null
          : Drawer(
              child: Column(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: colorLila),
                    child: Center(
                      child: Text(
                        "MENÚ AURA",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Inicio"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.grid_view),
                    title: const Text("Catálogo"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 3. SELECTORES DE UBICACIÓN Y FECHA (UNO SOBRE OTRO) ---
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enviar a:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // EDITAR: Selector de Ubicación (Arriba)
                  SelectorChip(
                    iconData: Icons.location_on,
                    text: "Ecatepec de Morelos",
                    iconColor: colorLila,
                  ),
                  const SizedBox(height: 10), // Espacio entre los dos botones
                  // EDITAR: Selector de Fecha (Abajo)
                  SelectorChip(
                    iconData: Icons.calendar_today,
                    text: "Miércoles 4 de marzo",
                    iconColor: colorLila,
                  ),
                ],
              ),
            ),

            // 4. SECCIÓN DE TÍTULO
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Regalos a domicilio",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Elige el detalle ideal para cualquier ocasión.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 5. BOTÓN ORDENAR Y FILTRAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                icon: const Icon(Icons.tune, size: 18, color: colorLila),
                label: const Text("Ordenar y Filtrar"),
              ),
            ),

            // 6. GRILLA DE PRODUCTOS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.count(
                crossAxisCount: esWeb ? 4 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.72,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  ProductCard(
                    title: "Clásico Ramo Ensueño",
                    price: "699",
                    imageUrl:
                        "https://raw.githubusercontent.com/SilvaLizet/imagenes_floreria_6J_2026/refs/heads/main/ramo.jpg",
                  ),
                  ProductCard(
                    title: "Clásico Arcoiris",
                    price: "899",
                    imageUrl:
                        "https://raw.githubusercontent.com/SilvaLizet/imagenes_floreria_6J_2026/refs/heads/main/ramo.jpg",
                  ),
                  ProductCard(
                    title: "Beige and white",
                    price: "1,569",
                    imageUrl:
                        "https://raw.githubusercontent.com/SilvaLizet/imagenes_floreria_6J_2026/refs/heads/main/ramo.jpg",
                  ),
                  ProductCard(
                    title: "Esencia",
                    price: "1,949",
                    imageUrl:
                        "https://raw.githubusercontent.com/SilvaLizet/imagenes_floreria_6J_2026/refs/heads/main/ramo.jpg",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
