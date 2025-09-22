import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class SosAlertPage extends StatefulWidget {
  @override
  _SosAlertPageState createState() => _SosAlertPageState();
}

class _SosAlertPageState extends State<SosAlertPage> {
  List<Map<String, String>> emergencyContacts = [
    {"name": "Police", "phone": "100"},
    {"name": "Vannya", "phone": "9650905729"},
    {"name": "Deepti", "phone": "9310874493"},
    {"name": "Charu", "phone": "8700203741"},
  ];

  Future<Position?> _getLiveLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void _addContact() async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Emergency Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                setState(() {
                  emergencyContacts.add({
                    "name": nameController.text,
                    "phone": phoneController.text,
                  });
                });
              }
              Navigator.of(ctx).pop();
            },
            child: const Text("Add"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _deleteContact(int index) {
    setState(() {
      emergencyContacts.removeAt(index);
    });
  }

  Future<void> _callContact(String phone) async {
    final Uri callUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to call $phone")));
    }
  }

  Future<void> _smsContact(String phone) async {
    Position? position = await _getLiveLocation();

    String message = "I am in danger.";
    if (position != null) {
      message += " My live location: https://maps.google.com/?q=${position.latitude},${position.longitude}";
    } else {
      message += " Location not available.";
    }

    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: {'body': message},
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to send SMS to $phone")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6E3),
      appBar: AppBar(
        title: const Text("SOS Alert"),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(22),
            ),
            width: double.infinity,
            child: const Column(
              children: [
                Icon(Icons.warning, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  "SOS ACTIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 4),
                Text("Reach your emergency contacts quickly.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emergencyContacts.length,
              itemBuilder: (context, index) {
                final contact = emergencyContacts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      contact["name"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: Text(
                      contact["phone"] ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.call, color: Colors.green),
                          onPressed: () => _callContact(contact["phone"] ?? ""),
                          tooltip: "Call",
                        ),
                        IconButton(
                          icon: const Icon(Icons.message, color: Colors.orange),
                          onPressed: () => _smsContact(contact["phone"] ?? ""),
                          tooltip: "Send SMS",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteContact(index),
                          tooltip: "Delete",
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton.icon(
              onPressed: _addContact,
              icon: const Icon(Icons.add),
              label: const Text("Add Emergency Contact"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
