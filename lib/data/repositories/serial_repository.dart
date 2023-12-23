import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:serial/serial.dart';

enum SerialConnectionStatus { connected, disconnected }

final class SerialRepository {
  SerialRepository(this.onConnectionUpdate);

  Future<SerialConnectionStatus> connect() async {
    try {
      final port = await window.navigator.serial.requestPort();
      await port.open(baudRate: 9600);

      final writer = port.writable.writer;
      await writer.ready;
      _reader = port.readable.reader;
      _writer = writer;

      onConnectionUpdate(SerialConnectionStatus.connected);
      return SerialConnectionStatus.connected;
    } catch (_) {
      return SerialConnectionStatus.disconnected;
    }
  }

  WritableStreamDefaultWriter? _writer;
  ReadableStreamReader? _reader;
  final void Function(SerialConnectionStatus status) onConnectionUpdate;

  Future<void> _sendData(List<int> data) async {
    try {
      _writer!.write(Uint8List.fromList(data));
      await _writer!.ready;
    } catch (_) {
      onConnectionUpdate(SerialConnectionStatus.disconnected);
      _reading = false;
      _reader = null;
      _writer = null;
    }
  }

  void sendOK() => _sendData(utf8.encode('1'));
  void sendBAD() => _sendData(utf8.encode('2'));

  bool _reading = false;
  Future<void> _startReading() async {
    if (_reading) {
      return;
    }
    _reading = true;

    final buffer = <int>[];

    while (_reading) {
      try {
        final data = await _reader!.read();

        buffer.addAll(data.value.toList());
        final newLineIndex = buffer.indexOf(10);
        if (newLineIndex != -1) {
          _streamController.add(utf8.decode(buffer.sublist(0, newLineIndex)));
          buffer.removeRange(0, newLineIndex + 1);
        }
      } catch (_) {
        onConnectionUpdate(SerialConnectionStatus.disconnected);
        _reading = false;
        _reader = null;
        _writer = null;
      }
    }
  }

  late final _streamController = StreamController<String>.broadcast(
    onListen: () => _startReading(),
    onCancel: () => _reading = false,
  );
  Stream<String> get wordStream => _streamController.stream;
}
