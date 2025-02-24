import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/inara_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Torvals Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Torvals Agent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final InaraApiService _apiService = InaraApiService();
  Map<String, dynamic>? factionData;
  bool isLoading = false;

  void _loadFactionData() async {
    setState(() => isLoading = true);
    final data = await _apiService.fetchFactionData();
    setState(() {
      factionData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : factionData == null
                ? Text("Noch keine Daten geladen.")
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(factionData.toString()), // JSON-Text ausgeben
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadFactionData,
        tooltip: 'Daten laden',
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}
