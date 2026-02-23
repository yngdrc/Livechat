part of 'livechat_view.dart';

class _LivechatPeerWidget extends StatelessWidget {
  const _LivechatPeerWidget({
    super.key,
    required this.selfId,
    required this.peer,
  });

  final String selfId;
  final dynamic peer;

  bool get isSelf => selfId == peer['id'];

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        ListTile(
          title: Text(
            isSelf
                ? peer['name'] + ', ID: ${peer['id']} ' + ' [Your self]'
                : peer['name'] + ', ID: ${peer['id']} ',
          ),
          onTap: null,
          trailing: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    isSelf ? Icons.close : Icons.videocam,
                    color: isSelf ? Colors.grey : Colors.black,
                  ),
                  onPressed: () {
                    context.read<LivechatBloc>().add(
                      LivechatEvent.invitePeer(peerId: peer['id']),
                    );
                  },
                  tooltip: 'Video calling',
                ),
              ],
            ),
          ),
          subtitle: Text('[${peer['user_agent']}]'),
        ),
        Divider(),
      ],
    );
  }
}
