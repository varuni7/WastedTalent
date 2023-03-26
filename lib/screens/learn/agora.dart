
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
class CallCard extends StatefulWidget {
  const CallCard({Key? key}) : super(key: key);
  @override
  State<CallCard> createState() => _CallCardState();
}
class _CallCardState extends State<CallCard> {
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: '5ef9b48c22384b14bf4faccc9d250bc0',
          channelName: 'Workshop',
          tempToken:
              '007eJxTYKj6finoK1t6dLuMN/Nv3wnaHdX1q++zHN/6OMzq/vHcWecVGExT0yyTTCySjYyMLUySDE2S0kzSEpOTky1TjEwNkpINghrkUxoCGRkmX/zNzMgAgSA+B0N4flF2cUZ+AQMDAENVIw8='));
  @override
  void initState() {
    super.initState();
    _initAgora();
  }
  _initAgora() async {
    await _client.initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: _client,
              enabledButtons: const [
                BuiltInButtons.toggleCamera,
                BuiltInButtons.callEnd,
                BuiltInButtons.toggleMic
              ],
            )
          ],
        ),
      ),
    );
  }
}
