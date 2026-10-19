import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SensiProApp());
}

class SensiProApp extends StatelessWidget {
  const SensiProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensi Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF080B12),
        primaryColor: const Color(0xFFEF4444),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  String brand = 'Xiaomi';
  String version = 'Android 13 - 15+';
  String ram = '4 GB - 6 GB';
  String style = 'Full Rush Gameplay';

  bool isGenerated = false;
  int gen = 196, redDot = 190, s2x = 184, s4x = 176, sniper = 125, freeLook = 140;
  String dpi = "420", btnSize = "46%";

  void calculateSensi() {
    setState(() {
      gen = 188; redDot = 182; s2x = 175; s4x = 168; sniper = 115; freeLook = 135;
      dpi = "420"; btnSize = "48%";

      if (ram.contains('2 GB')) {
        gen = 200; redDot = 198; s2x = 192; s4x = 188; dpi = "460"; btnSize = "44%";
      } else if (ram.contains('8 GB') || ram.contains('16 GB')) {
        gen = 184; redDot = 178; s2x = 170; s4x = 162; dpi = "395"; btnSize = "52%";
      }

      if (style.contains('Rush')) {
        gen = 200; redDot = (redDot + 10).clamp(0, 200); s2x = (s2x + 8).clamp(0, 200);
        btnSize = "45%"; freeLook = 160;
      } else if (style.contains('One Tap')) {
        gen = (gen + 4).clamp(0, 200); redDot = (redDot + 8).clamp(0, 200); btnSize = "42%";
      } else if (style.contains('Sniper')) {
        sniper = 145; gen = (gen - 10).clamp(0, 200); btnSize = "54%";
      }

      if (brand == 'Apple iPhone (iOS)') {
        dpi = "Default (iOS)"; gen = 180;
      }

      isGenerated = true;
    });
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('সেনসিটিভিটি কপি করা হয়েছে!'), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.gps_fixed, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('SENSI PRO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.red)),
              child: const Text('200 MAX', style: TextStyle(fontSize: 9, color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ActionChip(
              backgroundColor: Colors.sky.withOpacity(0.2),
              side: const BorderSide(color: Colors.sky),
              avatar: const Icon(Icons.send, size: 14, color: Colors.sky),
              label: const Text('Join TG', style: TextStyle(color: Colors.sky, fontSize: 11, fontWeight: FontWeight.bold)),
              onPressed: () => launchUrl(Uri.parse('https://t.me/cf0122'), mode: LaunchMode.externalApplication),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildGeneratorTab(),
          _buildProPlayersTab(),
          _buildAboutTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'জেনারেটর'),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'প্রো প্লেয়ার্স'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'অ্যাবাউট'),
        ],
      ),
    );
  }

  // --- TAB 1: GENERATOR ---
  Widget _buildGeneratorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown('ডিভাইস ব্র্যান্ড', brand, ['Xiaomi', 'Samsung', 'Realme', 'Vivo', 'Oppo', 'Infinix', 'OnePlus', 'Apple iPhone (iOS)'], (v) => setState(() => brand = v!)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildDropdown('ভার্সন', version, ['Android 8 - 10', 'Android 11 - 12', 'Android 13 - 15+', 'iOS 16 - 18+'], (v) => setState(() => version = v!))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildDropdown('র‍্যাম (RAM)', ram, ['2 GB - 3 GB', '4 GB - 6 GB', '8 GB - 12 GB', '16 GB+'], (v) => setState(() => ram = v!))),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDropdown('খেলার ধরন (Style)', style, ['Full Rush Gameplay', 'One Tap / Drag Headshot', 'Balanced', 'Sniper Specialist'], (v) => setState(() => style = v!)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: calculateSensi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('সেনসি তৈরি করুন (২০০ স্কেল)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          if (isGenerated) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('GENERATED (200 MAX)', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
                        onPressed: () => copyToClipboard('🔥 Sensi Pro 🔥\nGeneral: $gen/200\nRed Dot: $redDot/200\n2x: $s2x/200\n4x: $s4x/200\nSniper: $sniper/200\nFree Look: $freeLook/200\nDPI: $dpi\nFire Button: $btnSize\n\nBy CODEX FOYSAL | https://t.me/cf0122'),
                      )
                    ],
                  ),
                  _buildSliderView('General', gen, Colors.redAccent),
                  _buildSliderView('Red Dot', redDot, Colors.orangeAccent),
                  _buildSliderView('2x Scope', s2x, Colors.yellowAccent),
                  _buildSliderView('4x Scope', s4x, Colors.greenAccent),
                  _buildSliderView('Sniper Scope', sniper, Colors.sky),
                  _buildSliderView('Free Look', freeLook, Colors.purpleAccent),
                  const Divider(color: Colors.white12, height: 24),
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard('রিকমেন্ডেড DPI', dpi, Colors.amber)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildInfoCard('ফায়ার বাটন সাইজ', btnSize, Colors.redAccent)),
                    ],
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: const Color(0xFF080B12), borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderView(String title, int val, Color col) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
              Text('$val / 200', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: col)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: val / 200, backgroundColor: const Color(0xFF080B12), color: col, minHeight: 6),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String val, Color col) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFF080B12), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: col)),
        ],
      ),
    );
  }

  // --- TAB 2: PRO PLAYERS ---
  Widget _buildProPlayersTab() {
    final players = [
      {'name': 'RAISTAR', 'style': 'Movement God', 'gen': '198', 'red': '195', 'dpi': '440', 'btn': '48%'},
      {'name': 'WHITE444', 'style': 'Headshot Legend', 'gen': '200', 'red': '200', 'dpi': '480', 'btn': '42%'},
      {'name': 'RUOK FF', 'style': 'Auto Aim Master', 'gen': '194', 'red': '190', 'dpi': '410', 'btn': '46%'},
      {'name': 'NOBRU', 'style': 'World Champion', 'gen': '196', 'red': '192', 'dpi': '450', 'btn': '47%'},
      {'name': 'AJJUBHAI', 'style': 'Total Gaming', 'gen': '180', 'red': '174', 'dpi': '390', 'btn': '52%'},
      {'name': 'BADGE 99', 'style': 'Custom Specialist', 'gen': '195', 'red': '188', 'dpi': '430', 'btn': '45%'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final p = players[index];
        return Card(
          color: const Color(0xFF0F172A),
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.white.withOpacity(0.08))),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.red, child: Text(p['name']![0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            title: Text(p['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text(p['style']!, style: const TextStyle(fontSize: 11, color: Colors.redAccent)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.2),
                foregroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: const Color(0xFF0F172A),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (ctx) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${p['name']} SETTINGS', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Divider(),
                        Text('General: ${p['gen']}/200'),
                        Text('Red Dot: ${p['red']}/200'),
                        Text('DPI: ${p['dpi']} | Button: ${p['btn']}'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            copyToClipboard('🔥 ${p['name']} Sensi 🔥\nGeneral: ${p['gen']}\nRed Dot: ${p['red']}\nDPI: ${p['dpi']}\nButton: ${p['btn']}');
                            Navigator.pop(ctx);
                          },
                          child: const Text('কপি করুন'),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: const Text('ভিউ', style: TextStyle(fontSize: 12)),
            ),
          ),
        );
      },
    );
  }

  // --- TAB 3: ABOUT TAB ---
  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(16)),
            child: const Column(
              children: [
                CircleAvatar(radius: 30, backgroundColor: Colors.red, child: Icon(Icons.flash_on, size: 30, color: Colors.white)),
                SizedBox(height: 8),
                Text('SENSI PRO MAX', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Version 3.0.0 (Native Edition)', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildMemberCard('CODEX FOYSAL', 'Lead App Developer', Colors.red, 'DEV'),
          _buildMemberCard('Codex Pavel', 'Tool Admin', Colors.blueGrey, 'ADMIN'),
          _buildMemberCard('Codex Meraz', 'Community Admin', Colors.blueGrey, 'ADMIN'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse('https://t.me/cf0122'), mode: LaunchMode.externalApplication),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0284C7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text('টেলিগ্রাম চ্যানেলে জয়েন করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMemberCard(String name, String role, Color col, String tag) {
    return Card(
      color: const Color(0xFF0F172A),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(role, style: TextStyle(fontSize: 11, color: col)),
        trailing: Chip(backgroundColor: col.withOpacity(0.2), label: Text(tag, style: TextStyle(fontSize: 10, color: col))),
      ),
    );
  }
}
