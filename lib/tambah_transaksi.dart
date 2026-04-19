import 'package:flutter/material.dart';

class TambahTransaksiPage extends StatefulWidget {
  const TambahTransaksiPage({super.key});

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {

  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  String? kategori;
  String? jenis;

  // ✅ FIX MEMORY LEAK
  @override
  void dispose() {
    jumlahController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Tambah Transaksi"),
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Detail Transaksi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // JUMLAH
                    TextField(
                      controller: jumlahController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Jumlah Uang",
                        prefixIcon: Icon(Icons.money),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // KATEGORI
                    DropdownButtonFormField<String>(
                      value: kategori,
                      items: ["Makan", "Transport", "Gaji"]
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          kategori = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Kategori",
                        prefixIcon: Icon(Icons.category),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // KETERANGAN
                    TextField(
                      controller: keteranganController,
                      decoration: InputDecoration(
                        labelText: "Keterangan",
                        prefixIcon: Icon(Icons.note),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // JENIS
                    DropdownButtonFormField<String>(
                      value: jenis,
                      items: ["Pemasukan", "Pengeluaran"]
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          jenis = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Jenis Transaksi",
                        prefixIcon: Icon(Icons.swap_horiz),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                          // VALIDASI
                          if (jumlahController.text.isEmpty ||
                              kategori == null ||
                              jenis == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Lengkapi data dulu!")),
                            );
                            return;
                          }

                          // ✅ FIX BIAR GA CRASH
                          int? jumlah = int.tryParse(jumlahController.text);

                          if (jumlah == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Jumlah harus angka!")),
                            );
                            return;
                          }

                          Navigator.pop(context, {
                            "title": kategori,
                            "amount": jumlah,
                            "isMinus": jenis == "Pengeluaran",
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}