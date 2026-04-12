import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {

  Widget saldoCard(String title, String amount) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 5),
          Text(amount,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12))
      ],
    );
  }

  Widget transaksi(String title, String amount, bool isMinus) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.attach_money),
        ),
        title: Text(title),
        trailing: Text(
          amount,
          style: TextStyle(
            color: isMinus ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      appBar: AppBar(
        title: Text("KeuanganKu"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),

      body: Column(
        children: [

          SizedBox(height: 10),

          // SALDO
          Row(
            children: [
              Expanded(child: saldoCard("Saldo", "Rp 1.000.000")),
              Expanded(child: saldoCard("Pengeluaran", "Rp 200.000")),
            ],
          ),

          SizedBox(height: 20),

          // MENU
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              menuItem(Icons.add, "Tambah"),
              menuItem(Icons.bar_chart, "Statistik"),
              menuItem(Icons.history, "Riwayat"),
            ],
          ),

          SizedBox(height: 20),

          // JUDUL
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transaksi Terakhir",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // LIST TRANSAKSI
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                transaksi("Makan", "- Rp 20.000", true),
                transaksi("Transport", "- Rp 10.000", true),
                transaksi("Gaji", "+ Rp 2.000.000", false),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
}