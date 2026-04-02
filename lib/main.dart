import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKasir());
}

class AplikasiKasir extends StatelessWidget {
  const AplikasiKasir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir Sederhana',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const LayarKasir(),
    );
  }
}

class LayarKasir extends StatefulWidget {
  const LayarKasir({super.key});

  @override
  State<LayarKasir> createState() => _LayarKasirState();
}

class _LayarKasirState extends State<LayarKasir> {
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _hargaCtrl = TextEditingController();

  final List<Map<String, dynamic>> _keranjang = [];

  String _hasilStruk = "Belum ada transaksi";

  void _tambahBarang() {
    if (_namaCtrl.text.isNotEmpty && _hargaCtrl.text.isNotEmpty) {
      setState(() {
        _keranjang.add( {
          'nama': _namaCtrl.text,
          'harga': double.parse(_hargaCtrl.text)
          }
        );
      _namaCtrl.clear();
      _hargaCtrl.clear();
      });
    }
  }

  void _hitungTotal() {
    double subtotal = 0;

    for (int i = 0; i < _keranjang.length; i++) {
      subtotal = subtotal + _keranjang[i]['harga'];
    }

    double diskon = 0;
    String keteranganDiskon = "Tidak ada diskon";

    if (subtotal >= 100000) {
      diskon = subtotal * 0.25;
      keteranganDiskon = "Potongan 25%";
    } else if (subtotal >= 50000) {
      diskon = subtotal * 0.1;
      keteranganDiskon = "Potongan 10%";
    } else {
      diskon = 0;
    }

    double totalBayar = subtotal - diskon;

    setState(() {
      _hasilStruk = """
Subtotal : Rp $subtotal
Promo : $keteranganDiskon (Rp $diskon)
---------------------------------------
Total Bayar : Rp $totalBayar
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kasir'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _namaCtrl,
              decoration: const InputDecoration(labelText: 'Nama Barang'),
            ),

            TextField(
              controller: _hargaCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga Barang'),
            ),
            const SizedBox(height: 15,),

            ElevatedButton(
              onPressed: _tambahBarang, 
              child: const Text('Tambah ke keranjang'),
            ),

            const Divider(height: 40, thickness: 2,),

            const Text('Daftar Belanja', style: TextStyle(fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: _keranjang.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_keranjang[index]['nama']),
                    trailing: Text('Rp ${_keranjang[index]['harga']}'),
                  );
                },
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _hitungTotal, 
              child: const Text('Hitung Total', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                _hasilStruk,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

}