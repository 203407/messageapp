import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  } else if (message is String && tipo == 'location') {
    LocationData locationData = parseLocationDataFromString(message);
    return Container(
      width: 250,
      height: 300,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            position: LatLng(locationData.latitude!, locationData.longitude!),
          ),
        },
      ),
    );
  } else if (message is String && tipo == 'pdf') {
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

    return Container(
      width: 250,
      height: 300,
      child: SfPdfViewer.network(
        message,
        key: pdfViewerKey,
      ),
    );

    //   return Container(
    //     width: 20,
    //     child: SfPdfViewer.network(
    //       message,
    //     ),
    //   );

    // return Container(
    //   width: 250,
    //   height: 300,
    //   child: PDFView(
    //     filePath: message,
    //     onViewCreated: (PDFViewController pdfViewController) {
    //       // No es necesario hacer nada aquí
    //     },
    //   ),
    // );
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
    return Container();
  }
}

LocationData parseLocationDataFromString(String input) {
  final regex = RegExp(r'-?\d+\.\d+');
  final matches =
      regex.allMatches(input).map((match) => match.group(0)!).toList();

  if (matches.length == 2) {
    double latitude = double.parse(matches[0]);
    double longitude = double.parse(matches[1]);
    return LocationData.fromMap({
      "latitude": latitude,
      "longitude": longitude,
    });
  } else {
    throw FormatException('Invalid input format');
  }
}
