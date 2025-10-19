import 'package:flutter/material.dart';

// 🔹 Custom Button Widget
class MyCustomButton extends StatelessWidget {
  const MyCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Button Pressed!")),
        );
      },
      child: const Text(
        "Click Me",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

// 🔹 Custom Card Widget
class MyCustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const MyCustomCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: const Icon(Icons.widgets, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

// 🔹 Tab for showing UI Elements
class UIElementsTab extends StatelessWidget {
  const UIElementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MyCustomButton(),
          SizedBox(height: 20),
          MyCustomCard(
            title: "Flutter Custom Widget",
            subtitle: "This card is built using a reusable custom widget!",
          ),
        ],
      ),
    );
  }
}
