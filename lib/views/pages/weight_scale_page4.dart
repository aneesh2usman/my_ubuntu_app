import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_libserialport/flutter_libserialport.dart';

Stream<String> serialReadlines(
  SerialPortReader reader, {
  String terminator = '\n',
}) {
  final controller = StreamController<String>();
  String buffer = '';

  final subscription = reader.stream.listen(
    (data) {
      buffer += String.fromCharCodes(data);
      int index;
      while ((index = buffer.indexOf(terminator)) != -1) {
        final line = buffer.substring(0, index).trim();
        buffer = buffer.substring(index + terminator.length);
        controller.add(line);
      }
    },
    onError: controller.addError,
    onDone: controller.close,
    cancelOnError: false,
  );

  controller.onCancel = () => subscription.cancel();
  return controller.stream;
}

class WeightReaderPage4 extends StatefulWidget {
  @override
  _WeightReaderPage4State createState() => _WeightReaderPage4State();
}

class _WeightReaderPage4State extends State<WeightReaderPage4> {
  List<String> availablePorts = [];
  String? selectedPort;
  SerialPort? _port;
  SerialPortReader? _reader;
  StreamSubscription<String>? _subscription;
  String weightOutput = 'Waiting for data...';
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _listAvailablePorts();
  }

  void _listAvailablePorts() {
    setState(() {
      availablePorts = SerialPort.availablePorts;
    });
  }

  Future<void> _connectToPort(String portName) async {
    final port = SerialPort(portName);

    // Set port configuration BEFORE opening
    final config = port.config;
    config.baudRate = 9600;
    config.bits = 8;
    config.parity = SerialPortParity.none;
    config.stopBits = 1;
    config.setFlowControl(SerialPortFlowControl.none);
    port.config = config;

    // Add slight delay before opening
    await Future.delayed(Duration(milliseconds: 500));

    if (!port.openReadWrite()) {
      setState(() {
        weightOutput = 'Failed to open port: ${SerialPort.lastError}';
      });
      return;
    }

    final reader = SerialPortReader(port);
    final subscription = serialReadlines(reader).listen((line) {
      print('Line received: $line');
      setState(() {
        weightOutput = line;
      });
    });

    setState(() {
      _port = port;
      _reader = reader;
      _subscription = subscription;
      isConnected = true;
      weightOutput = 'Connected. Waiting for data...';
      selectedPort = portName;
    });
  }

  void _disconnectPort() {
    _subscription?.cancel();
    _reader?.close();
    _port?.close();

    setState(() {
      _reader = null;
      _port = null;
      _subscription = null;
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
            hint: const Text('Select COM Port'),
            items: availablePorts.map((port) {
              return DropdownMenuItem(
                value: port,
                child: Text(port),
              );
            }).toList(),
            onChanged: isConnected
                ? null
                : (value) {
                    setState(() {
                      selectedPort = value;
                    });
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
          const Text(
            'Weight Reading:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            weightOutput,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
