import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

enum SerialConnectionStatus { connected, disconnected }

final class SerialRepository {
  SerialRepository(this.onConnectionUpdate);

  SerialConnectionStatus connect() {
    final port = SerialPort.availablePorts
        .map((e) => SerialPort(e))
        .where((e) => e.transport == SerialPortTransport.usb)
        .firstOrNull;

    if (port == null) {
      log('No arduino found');
      return SerialConnectionStatus.disconnected;
    }

    if (!port.openReadWrite()) {
      log(SerialPort.lastError.toString());
      return SerialConnectionStatus.disconnected;
    }

    final config = SerialPortConfig();
    config.baudRate = 9600;
    config.bits = 8;
    config.stopBits = 1;
    port.config = config;
    final reader = SerialPortReader(port);

    _dataStream = reader.stream.asBroadcastStream();
    _arduino = port;

    onConnectionUpdate(SerialConnectionStatus.connected);
    return SerialConnectionStatus.connected;
  }

  SerialPort? _arduino;
  Stream<List<int>>? _dataStream;
  final void Function(SerialConnectionStatus status) onConnectionUpdate;

  void _sendData(List<int> data) {
    try {
      _arduino!.write(Uint8List.fromList(data));
    } on SerialPortError catch (_) {
      onConnectionUpdate(SerialConnectionStatus.disconnected);
      _dataStream = null;
      _arduino = null;
    }
  }

  void sendOK() => _sendData(utf8.encode('1'));
  void sendBAD() => _sendData(utf8.encode('2'));

  Stream<String> get wordStream async* {
    final buffer = <int>[];

    await for (final data in _dataStream!) {
      buffer.addAll(data);
      final newLineIndex = buffer.indexOf(10);
      if (newLineIndex != -1) {
        yield utf8.decode(buffer.sublist(0, newLineIndex));
        buffer.removeRange(0, newLineIndex + 1);
      }
    }
  }
}
