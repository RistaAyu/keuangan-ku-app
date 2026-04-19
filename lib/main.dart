import 'package:flutter/material.dart';
import 'tambah_transaksi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ================= DATA =================
  List<Map<String, dynamic>> transaksiList = [
    {"title": "Makan", "amount": 20000, "isMinus": true},
    {"title": "Transport", "amount": 10000, "isMinus": true},
    {"title": "Gaji", "amount": 2000000, "isMinus": false},
  ];

  int saldo = 1000000;
  int pengeluaran = 200000;

  // ================= FORMAT RUPIAH =================
  String formatRupiah(int number) {
    return "Rp " + number.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  }

  // ================= SALDO CARD =================
  Widget saldoCard(String title, int amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5F2EEA), Color(0xFF9B51E0)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text(
            formatRupiah(amount),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MENU ICON =================
  Widget menuTop(IconData icon, String label, {bool active = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: active ? Colors.deepPurple : Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6)
              ],
            ),
            child: Icon(
              icon,
              size: 22,
              color: active ? Colors.white : Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 65,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  // ================= ITEM TRANSAKSI =================
  Widget transaksiItem(Map<String, dynamic> item, int index) {
    int amount = item["amount"] ?? 0;
    bool isMinus = item["isMinus"] ?? true;

    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          if (isMinus) {
            pengeluaran -= amount;
            saldo += amount;
          } else {
            saldo -= amount;
          }
          transaksiList.removeAt(index);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple.withOpacity(0.1),
            child: const Icon(Icons.attach_money, color: Colors.deepPurple),
          ),
          title: Text(item["title"] ?? "-"),
          trailing: Text(
            (isMinus ? "- " : "+ ") + formatRupiah(amount),
            style: TextStyle(
              color: isMinus ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("KeuanganKu"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                transaksiList.clear();
                saldo = 0;
                pengeluaran = 0;
              });
            },
          )
        ],
      ),

      body: Column(
        children: [

          // ================= MENU KE KANAN =================
          Container(
  height: 110,
  margin: const EdgeInsets.only(top: 10),
  alignment: Alignment.centerRight, // 🔥 paksa ke kanan
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    reverse: true, // 🔥 mulai dari kanan
    child: Row(
      children: [

        // 🔥 URUTAN DIBALIK biar tampilannya benar dari kanan
        menuTop(Icons.elderly, "Pensiun"),
        menuTop(Icons.school, "Pendidikan"),
        menuTop(Icons.flight, "Liburan"),
        menuTop(Icons.directions_car, "Kendaraan"),
        menuTop(Icons.home, "Rumah"),
        menuTop(Icons.favorite, "Nikah"),
        menuTop(Icons.shopping_cart, "Belanja"),
        menuTop(Icons.receipt, "Tagihan"),
        menuTop(Icons.savings, "Tabungan"),

        // 🔥 MENU UTAMA (tetap ada tapi ikut kanan)
        menuTop(Icons.pie_chart, "Analisis"),
        menuTop(Icons.bar_chart, "Statistik"),
        menuTop(Icons.account_balance_wallet, "Keuangan", active: true),
      ],
    ),
  ),
),

          // ================= SALDO =================
          Row(
            children: [
              Expanded(child: saldoCard("Saldo", saldo)),
              Expanded(child: saldoCard("Pengeluaran", pengeluaran)),
            ],
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transaksi Terakhir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // ================= LIST =================
          Expanded(
            child: transaksiList.isEmpty
                ? const Center(
                    child: Text("Belum ada transaksi",
                        style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: transaksiList.length,
                    itemBuilder: (context, index) {
                      return transaksiItem(transaksiList[index], index);
                    },
                  ),
          ),
        ],
      ),

      // ================= TAMBAH =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahTransaksiPage(),
            ),
          );

          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              int amount = result["amount"] ?? 0;
              bool isMinus = result["isMinus"] ?? true;

              transaksiList.add(result);

              if (isMinus) {
                pengeluaran += amount;
                saldo -= amount;
              } else {
                saldo += amount;
              }
            });
          }
        },
      ),
    );
  }
}