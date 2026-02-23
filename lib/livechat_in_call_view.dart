part of 'livechat_view.dart';

class _LivechatInCallView extends StatelessWidget {
  const _LivechatInCallView({
    super.key,
    required this.localRenderer,
    required this.remoteRenderer,
  });

  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          children: <Widget>[
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.black54),
                child: RTCVideoView(remoteRenderer),
              ),
            ),
            Positioned(
              left: 20.0,
              top: 20.0,
              child: Container(
                width: orientation == Orientation.portrait ? 90.0 : 120.0,
                height: orientation == Orientation.portrait ? 120.0 : 90.0,
                decoration: BoxDecoration(color: Colors.black54),
                child: RTCVideoView(localRenderer, mirror: true),
              ),
            ),
          ],
        );
      },
    );
  }
}
