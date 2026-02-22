import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

class SimpleWebSocket {
  SimpleWebSocket(
    this._url, {
    required this.onOpen,
    required this.onMessage,
    required this.onClose,
  });

  final String _url;
  final VoidCallback onOpen;
  final Function(dynamic msg) onMessage;
  final Function(int? code, String? reason) onClose;

  WebSocket? _socket;

  connect() async {
    try {
      //_socket = await WebSocket.connect(_url);
      _socket = await _connectForSelfSignedCert(_url);
      onOpen();
      _socket?.listen(
        (data) => onMessage(data),
        onDone: () => onClose(_socket?.closeCode, _socket?.closeReason),
      );
    } catch (e) {
      onClose(500, e.toString());
    }
  }

  void send(data) {
    _socket?.add(data);
  }

  Future<void> close() async {
    await _socket?.close();
  }

  Future<WebSocket> _connectForSelfSignedCert(url) async {
    try {
      Random r = Random();
      String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
      HttpClient client = HttpClient(context: SecurityContext());
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
            print(
              'SimpleWebSocket: Allow self-signed certificate => $host:$port. ',
            );
            return true;
          };

      HttpClientRequest request = await client.getUrl(
        Uri.parse(url),
      ); // form the correct url here
      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add(
        'Sec-WebSocket-Version',
        '13',
      ); // insert the correct version here
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());

      HttpClientResponse response = await request.close();
      // ignore: close_sinks
      Socket socket = await response.detachSocket();
      var webSocket = WebSocket.fromUpgradedSocket(
        socket,
        protocol: 'signaling',
        serverSide: false,
      );

      return webSocket;
    } catch (e) {
      throw e;
    }
  }
}
