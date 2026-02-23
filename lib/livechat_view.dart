import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'livechat_bloc.dart';

part 'livechat_in_call_actions_widget.dart';

part 'livechat_in_call_view.dart';

part 'livechat_peer_widget.dart';

class LivechatView extends StatelessWidget {
  const LivechatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LivechatBloc(signaling: context.read())
          ..add(LivechatEvent.initialize());
      },
      child: BlocBuilder<LivechatBloc, LivechatState>(builder: _onBlocBuilder),
    );
  }

  Future<void> _onBlocPresentationListener(
    BuildContext context,
    LivechatEvent event,
  ) async {
    switch (event) {
      case ShowAcceptDialog _:
        await _showAcceptDialog(context);
      case ShowInviteDialog _:
        await _showInviteDialog(context);
      default:
        break;
    }
  }

  Widget _onBlocBuilder(BuildContext context, LivechatState state) {
    return BlocPresentationListener<LivechatBloc, LivechatEvent>(
      listener: _onBlocPresentationListener,
      child: Scaffold(
        appBar: AppBar(
          title: Text('P2P Call Sample [Your ID (${state.selfId})]}'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: state.inCalling
            ? _LivechatInCallActionsWidget()
            : null,
        body: state.inCalling
            ? _LivechatInCallView(
                localRenderer: state.localRenderer,
                remoteRenderer: state.remoteRenderer,
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                itemCount: (state.peers.length),
                itemBuilder: (context, i) {
                  return _LivechatPeerWidget(
                    selfId: state.selfId,
                    peer: state.peers[i],
                  );
                },
              ),
      ),
    );
  }

  Future<void> _showAcceptDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("title"),
          content: Text("accept?"),
          actions: [
            MaterialButton(
              child: Text('Reject', style: TextStyle(color: Colors.red)),
              onPressed: () {
                context.read<LivechatBloc>().add(LivechatEvent.reject());
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text('Accept', style: TextStyle(color: Colors.green)),
              onPressed: () {
                context.read<LivechatBloc>().add(LivechatEvent.accept());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInviteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("title"),
          content: Text("waiting"),
          actions: [
            TextButton(
              child: Text("cancel"),
              onPressed: () {
                context.read<LivechatBloc>().add(LivechatEvent.hangUp());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
