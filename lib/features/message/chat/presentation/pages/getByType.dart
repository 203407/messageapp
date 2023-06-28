import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

bool isSender(String friend, String current) {
  return friend == current;
}

Widget getWidgetForMessage(
    dynamic message, String usercurrent, String username, String tipo) {
  if (message is String && tipo == 'texto') {
    return Text(
      key: UniqueKey(),
      message,
      style: TextStyle(
        color: isSender(username, usercurrent) ? Colors.green : Colors.black,
      ),
      maxLines: 100,
      overflow: TextOverflow.ellipsis,
    );
  } else if (message is String && tipo == 'imagen') {
    return Image.network(
      message,
      width: 100,
    );
  } else if (message is String && tipo == 'video') {
    VideoPlayerController videoPlayerController =
        VideoPlayerController.network(message)..initialize();

    ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

    videoPlayerController.addListener(() {
      isPlayingNotifier.value = videoPlayerController.value.isPlaying ?? false;
    });

    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          child: AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (isPlayingNotifier.value) {
              videoPlayerController.pause();
            } else {
              videoPlayerController.play();
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isPlayingNotifier,
            builder: (context, value, child) {
              return Icon(value ? Icons.pause : Icons.play_arrow);
            },
          ),
        ),
      ],
    );
  } else if (message is String && tipo == 'audio') {
    AudioPlayer audioPlayer = AudioPlayer();
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () async {
        await audioPlayer.play(UrlSource(message));
      },
      child: Text('Reproducir Audio'),
    );
  } else {
    return Container(); // Si el tipo de mensaje no coincide con ninguno de los casos anteriores, devuelve un widget de contenedor vacío o puedes manejar el caso por defecto de otra manera.
  }
}
