import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class MedicationInfoScreen extends StatefulWidget {
  final String medicationName;

  const MedicationInfoScreen({super.key, required this.medicationName});

  @override
  State<MedicationInfoScreen> createState() => _MedicationInfoScreenState();
}

class _MedicationInfoScreenState extends State<MedicationInfoScreen> {
  final AiService _aiService = AiService();
  String? _info;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    try {
      final result = await _aiService.getMedicationInfo(widget.medicationName);
      setState(() {
        _info = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About ${widget.medicationName}')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : SingleChildScrollView(
                    child: Text(
                      _info ?? '',
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
      ),
    );
  }
}