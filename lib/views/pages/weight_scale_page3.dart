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
class WeightReaderPage3 extends StatefulWidget {
  @override
  _WeightReaderPage3State createState() => _WeightReaderPage3State();
}

class _WeightReaderPage3State extends State<WeightReaderPage3> {
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
        print('Failed to open port: ${SerialPort.lastError}');
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
    serialReadlines(reader!).listen((line) {
      print('Line: $line');
      setState(() {
        weightOutput = line;
      });
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
