import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

/// Controller class for handling serial communication.
/// This class is responsible for initializing the serial port, reading serial data,
/// updating the serial data value, and closing the serial port.
class SerialController extends GetxController {
  RxString serialData = "00.00".obs;
  String _buffer = '';
  SerialPort? _port;
  late SerialPortReader _reader;
  late StreamSubscription<Uint8List> _dataSubscription;
  final _baudrate = 9600;

  /// Initializes the serial port with the default configuration.
  void initializeSerialPort() {
    _port ??= SerialPort("COM8"); // Adjust to the correct port name
    final config = SerialPortConfig();
    config.baudRate = _baudrate;
    config.parity = 0;
    config.bits = 8;
    config.stopBits = 1;
    config.rts = 0;
    config.cts = 0;
    config.xonXoff = 0;
    _port!.config = config;
  }

  /// Reads the serial data from the serial port.
  /// It opens the serial port, listens for incoming data, and processes the received data.
  void readSerialData() async {
    initializeSerialPort();

    _reader = SerialPortReader(_port!, timeout: 20000);

    Stream<Uint8List> upcomingData = _reader.stream;

    try {
      if (_port!.isOpen) {
        _port!.close();
      }
      _port!.openReadWrite();

      var config = _port!.config;
      config.baudRate = _baudrate;
      _port!.config = config;

      _dataSubscription = upcomingData.listen((data) {
        print("data : $data");
        _buffer += String.fromCharCodes(data);

        int newlineIndex = _buffer.indexOf('\n');
        if (newlineIndex != -1) {
          String completeMessage =
              _buffer.toString().substring(0, newlineIndex).trim();

          completeMessage = completeMessage
              .replaceAll("\\r", "")
              .replaceAll("\\n", "")
              .replaceAll("'", "")
              .replaceAll("b", "")
              .replaceAll(",", " ")
              .replaceAll("+", "")
              .replaceAll("Kg", "")
              .replaceAll("kg", "");

          updateSerialData(completeMessage);
          _buffer = _buffer.substring(newlineIndex + 1);
        }
      });
    } on SerialPortError catch (err, _) {
      print('SerialPortError: $err');
      _port!.close();
      initializeSerialPort();
    }
  }

  /// Updates the serial data value and triggers a UI update.
  void updateSerialData(String data) {
    serialData.value = data;
    update();
  }

  /// Stops reading the serial data and closes the serial port.
  void stopReading() {
    _dataSubscription.cancel();
    _port?.close();
    updateSerialData('00.00');
  }

  @override
  void onClose() {
    stopReading();
    super.onClose();
  }
}

class SerialScaleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Serial Scale App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScaleScreen(),
    );
  }
}

class ScaleScreen extends StatefulWidget {
  @override
  _ScaleScreenState createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  final SerialController _serialController = Get.put(SerialController());

  @override
  void initState() {
    super.initState();
    _serialController.readSerialData(); // Start reading serial data
  }

  @override
  void dispose() {
    super.dispose();
    _serialController
        .stopReading(); // Stop reading serial data when the screen is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial Scale App'),
      ),
      body: Center(
        child: Obx(() {
          return Text(
            'Weight: ${_serialController.serialData.value} kg',
            style: TextStyle(fontSize: 24),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _serialController.stopReading();
        },
        tooltip: 'Stop Reading',
        child: Icon(Icons.stop),
      ),
    );
  }
}

void main() {
  runApp(SerialScaleApp());
}
