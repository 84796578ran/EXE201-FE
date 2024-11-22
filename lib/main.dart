import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ROOMSPOT',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashScreen.jpg'), // Đường dẫn hình nền
            fit: BoxFit.cover, // Tùy chỉnh hình nền full màn hình
          ),
        ),
        child: Column(
          children: [
            const Spacer(), // Đẩy nội dung xuống gần cuối màn hình
            const Center(
              child: Text(
                'ROOMSPOT',
                style: TextStyle(
                  fontSize: 48,

                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Màu chữ nổi bật trên hình nền
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(), // Tạo khoảng cách giữa nội dung chính và nút
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Khoảng cách nút tới đáy màn hình
              child: ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn nút
                  print('Bắt đầu nhấn!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu nền nút
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15), // Kích thước nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc nút
                  ),
                ),
                child: const Text(
                  'Bắt đầu',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Màu chữ trên nút
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
