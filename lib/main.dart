import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ Provider package
import 'Flutter_Widgets.dart'; // MyTextWidget
import 'Navigators.dart'; // HomeScreen, SecondScreen
import 'Media_Queries_&_breakpoints.dart'; // Responsive layouts
import 'Navigation_With_Namedroutes.dart'; // HomePage, AboutPage, ContactPage
import 'Responsive_UI.dart'; // Responsive UI demo
import 'Setstate_&_Provider.dart'; // ✅ For Provider demo
import 'Statefull_Widgets.dart'; // ✅ Stateful demo
import 'Stateless_Widgets.dart'; // ✅ New import for Stateless demo

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalCounter(), // ✅ from Setstate_&_Provider.dart
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Multi-Tab Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabDemoPage(),
    );
  }
}

class TabDemoPage extends StatelessWidget {
  const TabDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8, // ✅ Now 8 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Multi-Tab Demo"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Widget Tab"),
              Tab(text: "Navigation Tab"),
              Tab(text: "Breakpoints Tab"),
              Tab(text: "Responsive UI Tab"),
              Tab(text: "Named Routes Tab"),
              Tab(text: "SetState & Provider"),
              Tab(text: "Stateful Widgets"),
              Tab(text: "Stateless Widgets"), // ✅ New tab
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyTextWidget(), // Tab 1
            NavigationTab(), // Tab 2
            ResponsiveWrapper(), // Tab 3
            ResponsiveHome(), // Tab 4
            NamedRoutesWrapper(), // Tab 5
            CombinedCounterScreen(), // Tab 6 (Setstate & Provider)
            MyStatefulWidget(), // Tab 7 (Statefull_Widgets)
            MyStatelessWidget(), // ✅ Tab 8 (Stateless_Widgets)
          ],
        ),
      ),
    );
  }
}

/// Tab 2: Navigation button demo
class NavigationTab extends StatelessWidget {
  const NavigationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondScreen()),
          );
        },
        child: const Text("Go to Second Screen"),
      ),
    );
  }
}

/// Tab 3: Responsive layouts (breakpoints)
class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return const MobileLayout();
    } else if (screenWidth >= 600 && screenWidth < 1024) {
      return const TabletLayout();
    } else {
      return const DesktopLayout();
    }
  }
}

/// Tab 5: Named routes demo
class NamedRoutesWrapper extends StatelessWidget {
  const NamedRoutesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageTab();
  }
}

/// Wrapper for HomePage from Navigation_With_Namedroutes.dart
class HomePageTab extends StatelessWidget {
  const HomePageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🏠 Home")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPageTab()),
              );
            },
            child: const Text("Go to About Page"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPageTab()),
              );
            },
            child: const Text("Go to Contact Page"),
          ),
        ],
      ),
    );
  }
}

/// About Page for tab
class AboutPageTab extends StatelessWidget {
  const AboutPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ℹ️ About")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back to Home"),
        ),
      ),
    );
  }
}

/// Contact Page for tab
class ContactPageTab extends StatelessWidget {
  const ContactPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📞 Contact")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back to Home"),
        ),
      ),
    );
  }
}
