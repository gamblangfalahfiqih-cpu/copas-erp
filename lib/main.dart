// COPAS ERP - Complete Monolithic Implementation for Flutter Web
// Warung Copas Operational Management System

import 'package:flutter/material.dart';

void main() {
  runApp(const CopasErpApp());
}

class CopasErpApp extends StatelessWidget {
  const CopasErpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COPAS ERP - Warung Copas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// --- GLOBAL MOCK DATABASE & STATE ---
class AppState {
  static String currentUserRole = 'admin'; // 'admin', 'cashier', 'waiter', 'kitchen', 'customer'
  static String currentUserName = 'Super Admin';

  // Daftar Pegawai untuk Admin & Presensi
  static List<Map<String, dynamic>> employees = [
    {'id': 'EMP001', 'name': 'Ahmad Fauzi', 'role': 'Pelayan', 'shift': 'Pagi (08:00 - 16:00)', 'status': 'Aktif'},
    {'id': 'EMP002', 'name': 'Budi Santoso', 'role': 'Kasir', 'shift': 'Siang (14:00 - 22:00)', 'status': 'Aktif'},
    {'id': 'EMP003', 'name': 'Sinta Lestari', 'role': 'Dapur', 'shift': 'Pagi (08:00 - 16:00)', 'status': 'Aktif'},
  ];

  // Riwayat Presensi
  static List<Map<String, dynamic>> attendances = [
    {'name': 'Ahmad Fauzi', 'role': 'Pelayan', 'date': '2026-10-29', 'clockIn': '07:55', 'clockOut': '16:05', 'status': 'Hadir (Tepat Waktu)', 'hours': '7.1 Jam'},
    {'name': 'Budi Santoso', 'role': 'Kasir', 'date': '2026-10-29', 'clockIn': '13:50', 'clockOut': '-', 'status': 'Hadir (Belum Pulang)', 'hours': '-'},
    {'name': 'Sinta Lestari', 'role': 'Dapur', 'date': '2026-10-29', 'clockIn': '08:15', 'clockOut': '16:00', 'status': 'Terlambat (15 mnt)', 'hours': '6.8 Jam'},
  ];

  // Daftar Menu
  static List<Map<String, dynamic>> menus = [
    {'name': 'Kopi Susu Copas', 'category': 'Minuman', 'price': 18000, 'stock': 'Tersedia'},
    {'name': 'Nasi Goreng Special', 'category': 'Makanan', 'price': 25000, 'stock': 'Tersedia'},
    {'name': 'Roti Bakar Coklat Keju', 'category': 'Snack', 'price': 15000, 'stock': 'Tersedia'},
    {'name': 'Es Teh Manis', 'category': 'Minuman', 'price': 5000, 'stock': 'Tersedia'},
  ];

  // Daftar Pesanan
  static List<Map<String, dynamic>> orders = [
    {'id': 'ORD-001', 'table': 'Meja 01', 'items': '2x Kopi Susu, 1x Nasi Goreng', 'total': 61000, 'status': 'Diproses (Dapur)'},
    {'id': 'ORD-002', 'table': 'Meja 03', 'items': '1x Roti Bakar, 2x Es Teh', 'total': 25000, 'status': 'Siap Saji'},
  ];
}

// --- LOGIN SCREEN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(String role, String name) {
    AppState.currentUserRole = role;
    AppState.currentUserName = name;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.coffee, size: 64, color: Colors.amber),
              const SizedBox(height: 16),
              const Text('COPAS ERP', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
              const Text('Sistem Manajemen Warung Copas', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email / Username', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () => _login('admin', 'Super Admin'),
                child: const Text('Login as Admin', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              const Text('Atau pilih demo role cepat:', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(onPressed: () => _login('cashier', 'Budi (Kasir)'), child: const Text('Kasir')),
                  OutlinedButton(onPressed: () => _login('waiter', 'Ahmad (Pelayan)'), child: const Text('Pelayan')),
                  OutlinedButton(onPressed: () => _login('kitchen', 'Sinta (Dapur)'), child: const Text('Dapur')),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => _login('customer', 'Tamu Publik'),
                  child: const Text('Akses Halaman Publik & Booking Pelanggan', style: TextStyle(color: Colors.amber)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- MAIN DASHBOARD SHELL ---
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  List<Widget> _getPages() {
    switch (AppState.currentUserRole) {
      case 'admin':
        return [
          const AdminOverviewPage(),
          const AdminEmployeePage(),
          const AdminAttendancePage(),
          const AdminInventoryPage(),
          const AdminReportPage(),
        ];
      case 'cashier':
        return [const CashierTransactionPage(), const CashierBookingPage(), const PersonalAttendancePage()];
      case 'waiter':
        return [WaiterOrderPage(), const WaiterMonitoringPage(), const PersonalAttendancePage()];
      case 'kitchen':
        return [const KitchenOrderPage(), const KitchenInventoryPage(), const PersonalAttendancePage()];
      case 'customer':
      default:
        return [const CustomerPortalPage()];
    }
  }

  List<NavigationDestination> _getNavDestinations() {
    switch (AppState.currentUserRole) {
      case 'admin':
        return const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Manajemen Pegawai'),
          NavigationDestination(icon: Icon(Icons.access_time), label: 'Presensi & Shift'),
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Inventaris Stok'),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'Laporan & Keuangan'),
        ];
      case 'cashier':
        return const [
          NavigationDestination(icon: Icon(Icons.payment), label: 'Kasir & Transaksi'),
          NavigationDestination(icon: Icon(Icons.book_online), label: 'Kelola Booking'),
          NavigationDestination(icon: Icon(Icons.fingerprint), label: 'Presensi Saya'),
        ];
      case 'waiter':
        return const [
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Buat Pesanan'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Status Meja'),
          NavigationDestination(icon: Icon(Icons.fingerprint), label: 'Presensi Saya'),
        ];
      case 'kitchen':
        return const [
          NavigationDestination(icon: Icon(Icons.kitchen), label: 'Antrean Dapur'),
          NavigationDestination(icon: Icon(Icons.category), label: 'Stok Bahan Baku'),
          NavigationDestination(icon: Icon(Icons.fingerprint), label: 'Presensi Saya'),
        ];
      case 'customer':
      default:
        return const [
          NavigationDestination(icon: Icon(Icons.storefront), label: 'Informasi & Menu Cafe'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getPages();
    final destinations = _getNavDestinations();

    return Scaffold(
      appBar: AppBar(
        title: Text('COPAS ERP — (${AppState.currentUserName.toUpperCase()})'),
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      body: Row(
        children: [
          if (AppState.currentUserRole != 'customer')
            NavigationRail(
              selectedIndex: _selectedIndex < destinations.length ? _selectedIndex : 0,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.white,
              selectedIconTheme: IconThemeData(color: Colors.amber[800]),
              selectedLabelTextStyle: TextStyle(color: Colors.amber[800], fontWeight: FontWeight.bold),
              destinations: destinations.map((d) => NavigationRailDestination(icon: d.icon, label: Text(d.label))).toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: pages[_selectedIndex < pages.length ? _selectedIndex : 0],
          ),
        ],
      ),
    );
  }
}

// --- ADMIN PAGES ---
class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          const Text('Dashboard Utama Pemilik / Admin', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.8,
            children: [
              _buildStatCard('Total Pendapatan', 'Rp 3.450.000', Icons.attach_money, Colors.green),
              _buildStatCard('Total Pesanan', '48 Transaksi', Icons.receipt_long, Colors.blue),
              _buildStatCard('Karyawan Hadir', '12 / 14 Orang', Icons.people, Colors.orange),
              _buildStatCard('Stok Menipis', '2 Bahan', Icons.warning, Colors.red),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Aktivitas Operasional Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Transaksi Pembayaran #TRX-088 Selesai'), subtitle: Text('Kasir Budi — Rp 61.000 (QRIS)')),
                Divider(),
                ListTile(leading: Icon(Icons.fingerprint, color: Colors.blue), title: Text('Ahmad Fauzi Clock-In Tepat Waktu'), subtitle: Text('Shift Pagi (07:55)')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const Spacer(),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ],
      ),
    );
  }
}

class AdminEmployeePage extends StatefulWidget {
  const AdminEmployeePage({super.key});

  @override
  State<AdminEmployeePage> createState() => _AdminEmployeePageState();
}

class _AdminEmployeePageState extends State<AdminEmployeePage> {
  // Fungsi dialog diletakkan di dalam class state secara bersih
  void _addEmployeeDialog() {
    final nameCtrl = TextEditingController();
    String selectedRole = 'Pelayan';
    String selectedShift = 'Pagi (08:00 - 16:00)';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pegawai Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama Lengkap Pegawai')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: ['Pelayan', 'Kasir', 'Dapur'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (val) => selectedRole = val!,
              decoration: const InputDecoration(labelText: 'Role / Hak Akses'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedShift,
              items: ['Pagi (08:00 - 16:00)', 'Siang (14:00 - 22:00)'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => selectedShift = val!,
              decoration: const InputDecoration(labelText: 'Jadwal Shift Kerja'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                AppState.employees.add({
                  'id': 'EMP00${AppState.employees.length + 1}',
                  'name': nameCtrl.text,
                  'role': selectedRole,
                  'shift': selectedShift,
                  'status': 'Aktif',
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Manajemen Data Pegawai & Akun', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _addEmployeeDialog,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Pegawai'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[800], foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ListView(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nama Lengkap')),
                      DataColumn(label: Text('Role Sistem')),
                      DataColumn(label: Text('Shift Kerja')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: AppState.employees.map((emp) {
                      return DataRow(cells: [
                        DataCell(Text(emp['id'])),
                        DataCell(Text(emp['name'])),
                        DataCell(Text(emp['role'])),
                        DataCell(Text(emp['shift'])),
                        DataCell(Text(emp['status'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminAttendancePage extends StatelessWidget {
  const AdminAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Monitoring Presensi & Rekap Jam Kerja Karyawan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ListView(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Nama Karyawan')),
                      DataColumn(label: Text('Role')),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Clock-In')),
                      DataColumn(label: Text('Clock-Out')),
                      DataColumn(label: Text('Status Kehadiran')),
                      DataColumn(label: Text('Jam Efektif')),
                    ],
                    rows: AppState.attendances.map((att) {
                      return DataRow(cells: [
                        DataCell(Text(att['name'])),
                        DataCell(Text(att['role'])),
                        DataCell(Text(att['date'])),
                        DataCell(Text(att['clockIn'])),
                        DataCell(Text(att['clockOut'])),
                        DataCell(Text(att['status'])),
                        DataCell(Text(att['hours'], style: const TextStyle(fontWeight: FontWeight.bold))),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminInventoryPage extends StatelessWidget {
  const AdminInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Modul Inventaris Bahan Baku & Supplier (Admin View)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

class AdminReportPage extends StatelessWidget {
  const AdminReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Laporan Operasional Bulanan & Ekspor PDF/Excel', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

// --- PERSONAL ATTENDANCE (FOR STAFF) ---
class PersonalAttendancePage extends StatefulWidget {
  const PersonalAttendancePage({super.key});

  @override
  State<PersonalAttendancePage> createState() => _PersonalAttendancePageState();
}

class _PersonalAttendancePageState extends State<PersonalAttendancePage> {
  bool isClockedIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fingerprint, size: 80, color: Colors.amber),
          const SizedBox(height: 16),
          Text('Presensi Mandiri — ${AppState.currentUserName}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Silakan lakukan presensi masuk atau pulang sesuai jadwal shift Anda.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                onPressed: () {
                  setState(() => isClockedIn = true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil Clock-In! Jam kerja mulai dihitung.')));
                },
                icon: const Icon(Icons.login),
                label: const Text('CLOCK-IN (MASUK)'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                onPressed: () {
                  setState(() => isClockedIn = false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil Clock-Out! Jam kerja efektif dicatat.')));
                },
                icon: const Icon(Icons.logout),
                label: const Text('CLOCK-OUT (PULANG)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- CASHIER PAGES ---
class CashierTransactionPage extends StatelessWidget {
  const CashierTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Manajemen Transaksi & Pembayaran', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: AppState.orders.map((ord) {
                return Card(
                  child: ListTile(
                    title: Text('${ord['id']} — ${ord['table']}'),
                    subtitle: Text('${ord['items']} | Total: Rp ${ord['total']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pembayaran berhasil dikonfirmasi & Struk tercetak!')));
                      },
                      child: const Text('Proses Bayar'),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class CashierBookingPage extends StatelessWidget {
  const CashierBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Konfirmasi & Kelola Jadwal Booking Meja Pelanggan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

// --- WAITER PAGES ---
class WaiterOrderPage extends StatelessWidget {
  WaiterOrderPage({super.key});

  final _tableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Form Pemesanan Pelanggan (Pelayan)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: _tableController, decoration: const InputDecoration(labelText: 'Nomor Meja (Contoh: Meja 05)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          const Text('Pilih Menu:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView(
              children: AppState.menus.map((m) {
                return CheckboxListTile(
                  title: Text(m['name']),
                  subtitle: Text('Rp ${m['price']}'),
                  value: false,
                  onChanged: (bool? val) {},
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[800], foregroundColor: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pesanan berhasil dikirim ke Dapur!')));
            },
            child: const Text('Kirim Pesanan ke Dapur'),
          ),
        ],
      ),
    );
  }
}

class WaiterMonitoringPage extends StatelessWidget {
  const WaiterMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Monitoring Status Pesanan (Menunggu / Diproses / Siap Saji)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

// --- KITCHEN PAGES ---
class KitchenOrderPage extends StatelessWidget {
  const KitchenOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Antrean Pesanan Dapur & Resep Otomatis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: AppState.orders.map((ord) {
                return Card(
                  child: ListTile(
                    title: Text('${ord['id']} — ${ord['table']}'),
                    subtitle: Text('Menu: ${ord['items']}'),
                    trailing: DropdownButton<String>(
                      value: 'Diproses (Dapur)',
                      items: ['Menunggu', 'Diproses (Dapur)', 'Siap Saji'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) {},
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class KitchenInventoryPage extends StatelessWidget {
  const KitchenInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Manajemen Stok Bahan Baku & Peringatan Minimum Stok', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

// --- CUSTOMER PORTAL ---
class CustomerPortalPage extends StatelessWidget {
  const CustomerPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Selamat Datang di Warung Copas', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Nikmati kopi terbaik dan suasana santai. Silakan lihat menu atau lakukan booking meja.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          const Text('Daftar Menu Favorit:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: AppState.menus.map((m) {
                return Card(
                  child: ListTile(
                    title: Text(m['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Rp ${m['price']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}