import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: '1. Informasi Cuaca'),
              const SizedBox(height: 8),
              const Text(
                'Informasi cuaca dapat dilihat di halaman dashboard. Kamu bisa melihat cuaca saat ini dengan mudah langsung di bagian ini.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: '2. Data Sensor IoT'),
              const SizedBox(height: 8),
              const Text(
                'Aplikasi akan menampilkan data-data yang diukur oleh sensor tersebut, seperti kecepatan angin, suhu udara, dan lain-lain. Kamu bisa melihat data ini untuk mendapatkan informasi lebih rinci tentang lingkungan yang dipantau oleh sensor.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: '3. Kontrol Sprinkle Sprayer'),
              const SizedBox(height: 8),
              const Text(
                'Di halaman sprinkle, Anda bisa melihat status sprinkle sprayer yang digunakan apakah sudah hidup atau masih mati. Selain itu, ada tombol on/off untuk menghidupkan dan mematikan sprinkle sprayer tersebut.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
