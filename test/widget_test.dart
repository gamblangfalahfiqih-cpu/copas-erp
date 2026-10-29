import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:copas_erp/main.dart'; // Sesuaikan dengan nama paket Anda jika berbeda

void main() {
  testWidgets('COPAS ERP Login Screen Smoke Test', (WidgetTester tester) async {
    // 1. Jalankan aplikasi COPAS ERP
    await tester.pumpWidget(const CopasErpApp());

    // 2. Verifikasi bahwa judul aplikasi / teks login muncul di layar
    expect(find.text('COPAS ERP'), findsOneWidget);
    expect(find.text('Sistem Manajemen Warung Copas'), findsOneWidget);

    // 3. Verifikasi tombol "Login as Admin" ada
    expect(find.text('Login as Admin'), findsOneWidget);

    // 4. Uji interaksi klik tombol cepat Kasir
    await tester.tap(find.text('Kasir'));
    await tester.pumpAndSettle();

    // 5. Verifikasi bahwa aplikasi berhasil berpindah ke dashboard Kasir
    expect(find.text('COPAS ERP — (BUDI (KASIR))'), findsOneWidget);
  });
}