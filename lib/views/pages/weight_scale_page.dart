import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class WeightReaderPage extends StatefulWidget {
  @override
  _WeightReaderPageState createState() => _WeightReaderPageState();
}

class _WeightReaderPageState extends State<WeightReaderPage> {
  List<String> availablePorts = [];
  String? selectedPort;
  SerialPort? _port;
  SerialPortReader? reader;
  String weightOutput = 'Waiting for data...';
  String _serialBuffer = '';
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _listPorts();
  }

  void _listPorts() {
    setState(() {
      availablePorts = SerialPort.availablePorts;
    });
  }

  void _connectToPort(String portName) {
    _port = SerialPort(portName);
    if (!_port!.openReadWrite()) {
      setState(() {
        weightOutput = 'Failed to open port: ${SerialPort.lastError}';
      });
      return;
    }

    final config = _port!.config;
    config.baudRate = 9601;
    config.bits = 8;
    config.parity = SerialPortParity.none;
    config.stopBits = 1;
    config.setFlowControl(SerialPortFlowControl.none);
    _port!.config = config;

    reader?.close();
    reader = SerialPortReader(_port!);
    reader!.stream.listen((data) {
      final chunk = String.fromCharCodes(data.where((c) => c < 128));
      _serialBuffer += chunk;

      final newlineIndex = _serialBuffer.indexOf('\n');
      if (newlineIndex != -1) {
        final line = _serialBuffer.substring(0, newlineIndex).trim();
        _serialBuffer = _serialBuffer.substring(newlineIndex + 1);
        if (line.isNotEmpty) {
          setState(() {
            weightOutput = 'Weight: $line';
          });
        }
      }
    });

    setState(() {
      selectedPort = portName;
      isConnected = true;
      weightOutput = 'Connected. Waiting for data...';
    });
  }

  void _disconnectPort() {
    reader?.close();
    _port?.close();
    reader = null;
    _port = null;
    setState(() {
      isConnected = false;
      weightOutput = 'Disconnected.';
    });
  }

  @override
  void dispose() {
    _disconnectPort();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButton<String>(
            value: selectedPort,
            hint: Text('Select COM Port'),
            items: availablePorts.map((port) {
              return DropdownMenuItem(
                value: port,
                child: Text(port),
              );
            }).toList(),
            onChanged: isConnected
                ? null
                : (value) {
                    if (value != null) {
                      setState(() {
                        selectedPort = value;
                      });
                    }
                  },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (isConnected) {
                _disconnectPort();
              } else if (selectedPort != null) {
                _connectToPort(selectedPort!);
              }
            },
            child: Text(isConnected ? 'Disconnect' : 'Connect'),
          ),
          const SizedBox(height: 30),
          Text(
            'Weight Reading:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            weightOutput,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
