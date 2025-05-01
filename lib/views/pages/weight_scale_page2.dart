// First, add these dependencies to your pubspec.yaml:
// flutter_serial_port: ^0.6.0
// flutter_libserialport: ^0.3.0

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';



class ScaleReaderScreen extends StatefulWidget {
  const ScaleReaderScreen({Key? key}) : super(key: key);

  @override
  State<ScaleReaderScreen> createState() => _ScaleReaderScreenState();
}

class _ScaleReaderScreenState extends State<ScaleReaderScreen> {
  // Available ports
  List<String> _availablePorts = [];
  
  // Currently selected port
  String? _selectedPort;
  
  // Serial port instance
  SerialPort? _port;
  
  // Serial port reader
  SerialPortReader? _reader;
  
  // Reading state
  bool _isReading = false;
  
  // Current weight reading
  String _currentWeight = "0.00";
  
  // For configuring the port
  final TextEditingController _baudRateController = TextEditingController(text: "9600");
  final TextEditingController _dataBitsController = TextEditingController(text: "8");
  final TextEditingController _stopBitsController = TextEditingController(text: "1");
  
  // For testing
  final TextEditingController _testMessageController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _refreshPorts();
  }
  
  @override
  void dispose() {
    _stopReading();
    _baudRateController.dispose();
    _dataBitsController.dispose();
    _stopBitsController.dispose();
    _testMessageController.dispose();
    super.dispose();
  }
  
  // Refresh the list of available ports
  void _refreshPorts() {
    setState(() {
      _availablePorts = SerialPort.availablePorts;
    });
  }
  
  // Start reading from the selected port
  void _startReading() {
    if (_selectedPort == null) return;
    
    try {
      // Close port if it's already open
      _stopReading();
      
      // Configure the port
      _port = SerialPort(_selectedPort!);
      
      // Configure port settings
      _port!.openReadWrite();
      _port!.config.baudRate = int.parse(_baudRateController.text);
      _port!.config.bits = int.parse(_dataBitsController.text);
      _port!.config.stopBits = int.parse(_stopBitsController.text);
      _port!.config.parity = SerialPortParity.none;
      _port!.config.setFlowControl(SerialPortFlowControl.none);
      
      // Create reader
      _reader = SerialPortReader(_port!);
      
      // Listen for data
      _reader!.stream.listen((data) {
        _processReceivedData(data);
      });
      
      setState(() {
        _isReading = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected to $_selectedPort'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'))
      );
    }
  }
  
  // Stop reading from the port
  void _stopReading() {
    _reader?.close();
    _port?.close();
    _reader = null;
    _port = null;
    
    setState(() {
      _isReading = false;
    });
  }
  
  // Buffer to accumulate data coming in chunks
  StringBuffer _dataBuffer = StringBuffer();
  bool _isReceivingData = false;
  
  // Process data received from the scale
  void _processReceivedData(Uint8List data) {
    // Convert bytes to string
    String dataString = String.fromCharCodes(data);
    
    // Print raw data for debugging
    print('Raw data: ${data.map((e) => e.toRadixString(16)).join(' ')}');
    print('String data: $dataString');
    
    // Add the incoming data to our buffer
    _dataBuffer.write(dataString);
    
    // Check if this is the start of a new reading (K+0)
    if (dataString.contains('K+0')) {
      _isReceivingData = true;
      _dataBuffer.clear();
      _dataBuffer.write(dataString);
    }
    
    // Look for a complete reading in our buffer
    String bufferContent = _dataBuffer.toString();
    
    // Based on your data, it looks like a complete reading follows this pattern:
    // It starts with "K+0" followed by digits and a decimal point
    if (_isReceivingData && bufferContent.contains('K+0')) {
      // Extract the numeric portion
      RegExp weightRegex = RegExp(r'\d+\.?\d*');
      final matches = weightRegex.allMatches(bufferContent);
      
      // Combine all number matches into one reading
      if (matches.isNotEmpty) {
        String combinedWeight = "";
        for (final match in matches) {
          combinedWeight += match.group(0) ?? "";
        }
        
        if (combinedWeight.isNotEmpty) {
          setState(() {
            _currentWeight = combinedWeight;
          });
          
          // Reset buffer after successful reading
          if (combinedWeight.contains('.')) {
            _dataBuffer.clear();
            _isReceivingData = false;
          }
        }
      }
    }
  }
  
  // Send test data to the port
  void _sendTestData() {
    if (_port != null && _port!.isOpen && _testMessageController.text.isNotEmpty) {
      try {
        // Add newline if needed for your device
        String message = _testMessageController.text + '\r\n';
        List<int> bytes = message.codeUnits;
        _port!.write(Uint8List.fromList(bytes));
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sent: ${_testMessageController.text}'))
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Send error: ${e.toString()}'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weight display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Weight',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentWeight,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('kg'),
                  const SizedBox(height: 16),
                  Text(
                    'Raw Buffer: ${_dataBuffer.toString()}',
                    style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Port selection
            const Text('COM Port Settings:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Port',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPort,
                    items: _availablePorts.map((port) {
                      return DropdownMenuItem(
                        value: port,
                        child: Text(port),
                      );
                    }).toList(),
                    onChanged: _isReading 
                        ? null 
                        : (value) {
                            setState(() {
                              _selectedPort = value;
                            });
                          },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isReading ? _stopReading : _startReading,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isReading ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isReading ? 'Disconnect' : 'Connect'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Port configuration
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _baudRateController,
                    decoration: const InputDecoration(
                      labelText: 'Baud Rate',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !_isReading,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _dataBitsController,
                    decoration: const InputDecoration(
                      labelText: 'Data Bits',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !_isReading,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _stopBitsController,
                    decoration: const InputDecoration(
                      labelText: 'Stop Bits',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !_isReading,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Test send data (for debugging)
            const Text('Test Communication:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _testMessageController,
                    decoration: const InputDecoration(
                      labelText: 'Test Message',
                      border: OutlineInputBorder(),
                      hintText: 'Enter text to send to device',
                    ),
                    enabled: _isReading,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isReading ? _sendTestData : null,
                  child: const Text('Send'),
                ),
              ],
            ),
            
            const Spacer(),
            
            // Debug information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Debug Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Status: ${_isReading ? "Connected" : "Disconnected"}'),
                  Text('Selected Port: ${_selectedPort ?? "None"}'),
                  Text('Available Ports: ${_availablePorts.join(", ")}'),
                ],
              ),
            ),
          ],
        ),
      );
  }
}