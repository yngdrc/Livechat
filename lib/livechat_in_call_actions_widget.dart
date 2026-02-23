part of 'livechat_view.dart';

class _LivechatInCallActionsWidget extends StatelessWidget {
  const _LivechatInCallActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            tooltip: 'Camera',
            onPressed: () {
              context.read<LivechatBloc>().add(LivechatEvent.switchCamera());
            },
            child: const Icon(Icons.switch_camera),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<LivechatBloc>().add(LivechatEvent.hangUp());
            },
            tooltip: 'Hangup',
            backgroundColor: Colors.pink,
            child: Icon(Icons.call_end),
          ),
          FloatingActionButton(
            tooltip: 'Mute Mic',
            onPressed: () {
              context.read<LivechatBloc>().add(
                LivechatEvent.toggleMicrophone(),
              );
            },
            child: const Icon(Icons.mic_off),
          ),
        ],
      ),
    );
  }
}
