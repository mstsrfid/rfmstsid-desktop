import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

enum SerialConnectionStatus { connected, disconnected }

final class SerialRepository {
  SerialRepository(this.onConnectionUpdate) {
    connect();
  }

  SerialConnectionStatus connect() {
    final ports = SerialPort.availablePorts
        .map((e) => SerialPort(e))
        .where((e) => e.transport == SerialPortTransport.usb);

    _arduino = ports.cast<SerialPort?>().firstWhere(
          (e) => e!.vendorId == 9025,
          orElse: () => null,
        );

    if (_arduino == null) {
      onConnectionUpdate(SerialConnectionStatus.disconnected);
      return SerialConnectionStatus.disconnected;
    }

    if (_arduino!.isOpen) {
      _arduino!.close();
    }

    if (!_arduino!.openReadWrite()) {
      log(SerialPort.lastError.toString());
      onConnectionUpdate(SerialConnectionStatus.disconnected);
      return SerialConnectionStatus.disconnected;
    }

    _reader = SerialPortReader(_arduino!);
    _dataStream = _reader!.stream.asBroadcastStream();

    onConnectionUpdate(SerialConnectionStatus.connected);
    return SerialConnectionStatus.connected;
  }

  SerialPort? _arduino;
  SerialPortReader? _reader;
  Stream<List<int>>? _dataStream;
  final void Function(SerialConnectionStatus status) onConnectionUpdate;

  bool get isConnected => _arduino != null;

  void _sendData(List<int> data) {
    try {
      _arduino!.write(Uint8List.fromList(data));
    } on SerialPortError catch (_) {
      onConnectionUpdate(SerialConnectionStatus.disconnected);
      _arduino!.close();
      _reader!.close();
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
