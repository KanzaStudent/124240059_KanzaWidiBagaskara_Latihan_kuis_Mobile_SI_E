import 'package:flutter/material.dart';
import 'food_item.dart';

class DetailPage extends StatefulWidget {
  final FoodItem item;
  const DetailPage({super.key, required this.item});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final TextEditingController _controller;
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.item.quantity;
    _controller = TextEditingController(text: _qty.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(item.imageUrl, height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(item.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Rp ${item.formattedPrice} / porsi', style: const TextStyle(color: Colors.green)),
          const SizedBox(height: 8),
          Text(item.description),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Jumlah (porsi)',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _qty = int.tryParse(v) ?? 0),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text('Rp ${formatPrice(_qty * item.price)}',
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, _qty),
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Simpan Pemesanan'),
          ),
        ],
      ),
    );
  }
}