import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String status = "Online";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.brown[200],
                child: const Text("Fe", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              const Text("Keval",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              DropdownButton<String>(
                value: status,
                underline: Container(),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (value) {
                  setState(() => status = value!);
                },
                items: ["Online", "Away"]
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  color: s == "Online"
                                      ? Colors.green
                                      : Colors.orange,
                                  size: 10),
                              const SizedBox(width: 8),
                              Text(s),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(width: 10),
              Text("Add account", style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 20),
          ...settingsItems.map((item) => SettingTile(item: item)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.link, color: Colors.teal),
            Icon(Icons.chat_bubble_outline, color: Colors.blue),
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.brown,
              child: Text("Ke",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  SettingItem(this.icon, this.title, this.subtitle, this.color);
}

final List<SettingItem> settingsItems = [
  SettingItem(Icons.lock_open, "Sign in options", "Password and e-mail",
      Colors.deepPurple),
  SettingItem(
      Icons.link, "Link to you", "Direct link to your chat", Colors.lightBlue),
  SettingItem(Icons.mail, "Welcome message", "Add, edit, delete", Colors.brown),
  SettingItem(Icons.notifications, "Notifications", "Mute or unmute chats",
      Colors.amber),
  SettingItem(Icons.storage, "Storage", "Set cache limits", Colors.teal),
  SettingItem(Icons.lock, "Confidentiality", "Blocked users", Colors.grey),
  SettingItem(
      Icons.brush, "Interface", "Language, background, ...", Colors.deepPurple),
  SettingItem(Icons.devices, "Linked devices", "Active sessions", Colors.green),
];

class SettingTile extends StatelessWidget {
  final SettingItem item;
  const SettingTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.color.withOpacity(0.2),
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(item.title),
        subtitle: Text(item.subtitle),
        onTap: () {},
      ),
    );
  }
}
