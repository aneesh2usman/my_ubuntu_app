import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data'; // Added for Uint8List
import 'package:flutter_libserialport/flutter_libserialport.dart';

class WeightReaderPage4 extends StatefulWidget {
  @override
  _WeightReaderPage4State createState() => _WeightReaderPage4State();
}

class _WeightReaderPage4State extends State<WeightReaderPage4> {
  List<String> availablePorts = [];
  String? selectedPort;
  SerialPort? _port;
  SerialPortReader? reader;
  StreamSubscription? _subscription;
  String weightOutput = 'Waiting for data...';
  String _serialBuffer = '';
  bool isConnected = false;

  // Serial configuration options
  int _baudRate = 9600;
  int _dataBits = 8;
  int _stopBits = 1;

  // Common baud rates for scales
  final List<int> _commonBaudRates = [
    1200,
    2400,
    4800,
    9600,
    19200,
    38400,
    57600,
    115200
  ];

  @override
  void initState() {
    super.initState();
    _refreshPorts();
  }

  void _refreshPorts() {
    setState(() {
      try {
        availablePorts = SerialPort.availablePorts;
      } catch (e) {
        print('Error listing ports: $e');
        weightOutput = 'Error listing ports: $e';
        availablePorts = [];
      }
    });
  }

  void _connectToPort(String portName) {
    try {
      _port = SerialPort(portName);

      // Try to open with read/write access
      if (!_port!.openReadWrite()) {
        print('Failed to open port: ${SerialPort.lastError}');
        setState(() {
          weightOutput = 'Failed to open port: ${SerialPort.lastError}';
        });
        return;
      }

      // Configure the port
      try {
        final config = _port!.config;
        config.baudRate = _baudRate;
        config.bits = _dataBits;
        config.parity = SerialPortParity.none;
        config.stopBits = _stopBits;
        config.setFlowControl(SerialPortFlowControl.none);
        _port!.config = config;
      } catch (e) {
        print('Failed to configure port: $e');
        setState(() {
          weightOutput = 'Failed to configure port: $e';
        });
        _port?.close();
        return;
      }

      // Set up the reader with a more flexible approach
      reader?.close();
      reader = SerialPortReader(_port!, timeout: 500);

      _subscription?.cancel();
      _subscription = reader!.stream.listen(
        (data) {
          _processSerialData(data);
        },
        onError: (error) {
          print('Serial error: $error');
          setState(() {
            weightOutput = 'Serial error: $error';
          });
        },
        onDone: () {
          print('Serial connection closed');
          setState(() {
            isConnected = false;
            weightOutput = 'Connection closed';
          });
        },
      );

      setState(() {
        selectedPort = portName;
        isConnected = true;
        weightOutput = 'Connected. Waiting for data...';
      });
    } catch (e) {
      print('Exception while connecting: $e');
      setState(() {
        weightOutput = 'Error: $e';
      });
    }
  }

  void _processSerialData(Uint8List data) {
    // First, add the incoming data to our buffer
    String incoming = String.fromCharCodes(data);
    _serialBuffer += incoming;

    // Debug the raw data
    print(
        'Raw data received: ${data.map((b) => '0x${b.toRadixString(16).padLeft(2, '0')}').join(' ')}');

    // Try multiple terminators (CR, LF, CRLF)
    bool foundTerminator = false;

    // First check for CRLF
    int crlfIndex = _serialBuffer.indexOf('\r\n');
    if (crlfIndex != -1) {
      String line = _serialBuffer.substring(0, crlfIndex).trim();
      _serialBuffer = _serialBuffer.substring(crlfIndex + 2);
      _processWeightLine(line);
      foundTerminator = true;
    }
    // Then check for just CR
    else {
      int crIndex = _serialBuffer.indexOf('\r');
      if (crIndex != -1) {
        String line = _serialBuffer.substring(0, crIndex).trim();
        _serialBuffer = _serialBuffer.substring(crIndex + 1);
        _processWeightLine(line);
        foundTerminator = true;
      }
      // Finally check for just LF
      else {
        int lfIndex = _serialBuffer.indexOf('\n');
        if (lfIndex != -1) {
          String line = _serialBuffer.substring(0, lfIndex).trim();
          _serialBuffer = _serialBuffer.substring(lfIndex + 1);
          _processWeightLine(line);
          foundTerminator = true;
        }
      }
    }

    // If we found and processed a terminator, check for more in the buffer
    if (foundTerminator) {
      // If there's still data in the buffer, process it recursively
      if (_serialBuffer.contains('\r') || _serialBuffer.contains('\n')) {
        _processSerialData(
            Uint8List(0)); // Call with empty data to process the buffer
      }
    }
    // If no terminator found and buffer is getting too large, try to extract a weight value
    else if (_serialBuffer.length > 100) {
      _processWeightLine(_serialBuffer);
      _serialBuffer = '';
    }
  }

  void _processWeightLine(String line) {
    print('Processing line: "$line"');

    if (line.isEmpty) return;

    // Try to extract numeric values (common for scales)
    RegExp numericRegex = RegExp(r'[+-]?\d+(\.\d+)?');
    var matches = numericRegex.allMatches(line);

    if (matches.isNotEmpty) {
      String weightValue = matches.first.group(0) ?? '';
      setState(() {
        weightOutput = weightValue;
      });
    } else {
      // If no numeric value found, just show the raw line
      setState(() {
        weightOutput = line;
      });
    }
  }

  void _disconnectPort() {
    _subscription?.cancel();
    _subscription = null;
    reader?.close();
    _port?.close();
    reader = null;
    _port = null;
    setState(() {
      isConnected = false;
      weightOutput = 'Disconnected.';
      _serialBuffer = '';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _refreshPorts,
                child: Text('Refresh Ports'),
              ),
              Text('Available Ports: ${availablePorts.length}'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedPort,
                  hint: Text('Select COM Port'),
                  isExpanded: true,
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
              ),
              SizedBox(width: 20),
              DropdownButton<int>(
                value: _baudRate,
                hint: Text('Baud Rate'),
                items: _commonBaudRates.map((rate) {
                  return DropdownMenuItem(
                    value: rate,
                    child: Text('$rate'),
                  );
                }).toList(),
                onChanged: isConnected
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() {
                            _baudRate = value;
                          });
                        }
                      },
              ),
            ],
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 30),
          Text(
            'Weight Reading:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weightOutput,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Connection Status:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            isConnected ? 'Connected to $selectedPort' : 'Disconnected',
            style: TextStyle(
              color: isConnected ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
