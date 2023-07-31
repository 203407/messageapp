import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messageapp/features/message/chat/presentation/blocs/chats_bloc.dart';
import 'package:messageapp/features/message/chat/presentation/blocs/message/message_bloc.dart';

import 'package:messageapp/features/message/chat/presentation/pages/getByType.dart';
import 'package:video_player/video_player.dart';

import 'package:location/location.dart';

class SignF3 extends StatefulWidget {
  const SignF3(
      {Key? key,
      required this.username,
      required this.currentUser,
      required this.correousuario})
      : super(key: key);

  final String? username;
  final String? currentUser;
  final String? correousuario;

  @override
  State<SignF3> createState() => _SignFState();
}

class _SignFState extends State<SignF3> {
  String _message = '';
  bool statussend = true;
  final ImagePicker _imagePicker = ImagePicker();

  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  var _textController = TextEditingController();
  VideoPlayerController? _videoPlayerController;
  var docid = '';

  @override
  void initState() {
    super.initState();
    var friendUid = widget.username;
    var currentUserUid = widget.currentUser;
    statussend = true;

    context.read<ChatBloc>().add(
        GetDocIdtUsers(friendUid: friendUid!, currentUserUid: currentUserUid!));
  }

  bool isSender(String friend) {
    return friend == widget.currentUser;
  }

  Alignment getAligment(friend) {
    if (friend == widget.currentUser) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          if (statussend) {
            print("getting mensajes //////////////");
            print(state.docid);
            docid = state.docid;
            context
                .read<MessageBloc>()
                .add(GetMessages(username: state.docid, docid: state.docid));

            statussend = false;
          }
          return Scaffold(body: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              if (state is Loadings) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loadeds) {
                return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      previousPageTitle: "back",
                      middle: Text(widget.username!),
                      trailing: Text(widget.correousuario!),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          state.messages.isNotEmpty
                              ? Expanded(
                                  child: ListView(
                                  reverse: true,
                                  children: state.messages.map(((e) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          child: ChatBubble(
                                            clipper: ChatBubbleClipper6(
                                                nipSize: 0,
                                                radius: 0,
                                                type:
                                                    BubbleType.receiverBubble),
                                            alignment: getAligment(
                                                e.username.toString()),
                                            margin: EdgeInsets.only(top: 20),
                                            backGroundColor:
                                                isSender(e.username.toString())
                                                    ? Color.fromARGB(
                                                        255, 19, 188, 245)
                                                    : Color.fromARGB(
                                                        255, 151, 229, 255),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      getWidgetForMessage(
                                                          e.msg,
                                                          widget.currentUser!,
                                                          widget.username!,
                                                          e.tipo)
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        e.creadoen == null
                                                            ? DateTime.now()
                                                                .toString()
                                                            : e.creadoen
                                                                .toDate()
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: isSender(e
                                                                  .username
                                                                  .toString())
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })).toList(),
                                ))
                              : const Expanded(
                                  child: Text('sin mensjes'),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: CupertinoTextField(
                                controller: _textController,
                                onSubmitted: ((value) {
                                  if (value.isNotEmpty) {
                                    sendMessage(
                                        context, state.docid, 'texto', value);
                                    _textController.clear();
                                  }
                                }),
                              )),
                              CupertinoButton(
                                  child: const Icon(Icons.settings_voice),
                                  onPressed: () {
                                    getAudio(context, state.docid);
                                  }),
                              CupertinoButton(
                                  child: const Icon(Icons.switch_video),
                                  onPressed: () {
                                    getVideo(context, state.docid);
                                  }),
                              CupertinoButton(
                                  child: const Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    getImage(context, state.docid);
                                  }),
                              CupertinoButton(
                                  child: const Icon(Icons.document_scanner),
                                  onPressed: () {
                                    getPdf(context, state.docid);
                                  }),
                              CupertinoButton(
                                  child: const Icon(Icons.location_city),
                                  onPressed: () {
                                    getLocation(context, state.docid);
                                  }),
                            ],
                          )
                        ],
                      ),
                    ));
              } else if (state is ErrorM) {
                return Center(
                  child: Text(state.error,
                      style: const TextStyle(color: Colors.red)),
                );
              } else {
                context.read<ChatBloc>().add(GetDocIdtUsers(
                    friendUid: widget.username!,
                    currentUserUid: widget.currentUser!));
                statussend = true;

                return Text('data');
              }
            },
          ));
        } else if (state is Error) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return const Text('s');
        }
      },
    ));
  }

  void sendMessage(BuildContext context, docid, tipo, msg) {
    context.read<MessageBloc>().add(SendMessage(
        msg: msg,
        tipo: tipo,
        currentUser: widget.currentUser.toString(),
        docId: docid));
    _textController.clear();

    Future.delayed(Duration(seconds: 1), () {
      context
          .read<MessageBloc>()
          .add(GetMessages(username: docid, docid: docid));
    });
  }

  void getImage(BuildContext context, docid) async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      String url = await uploadFile('images/${xFile.name}', File(xFile.path));

      // ignore: use_build_context_synchronously
      sendMessage(context, docid, 'imagen', url);
    } else {
      print('No se seleccionó ninguna imagen.');
    }
  }

  void getVideo(BuildContext context, docid) async {
    XFile? xFile = await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (xFile != null) {
      String url = await uploadFile('videos/${xFile.name}', File(xFile.path));

      // ignore: use_build_context_synchronously
      sendMessage(context, docid, 'video', url);
    } else {
      print('No se seleccionó ningún video.');
    }
  }

  void getLocation(BuildContext context, docid) async {
    // XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    // if (xFile != null) {
    // String url = await uploadFile('images/${xFile.name}', File(xFile.path));

    // ignore: use_build_context_synchronously

    Location location = Location();

    // LocationData? currentLocation;

    location.getLocation().then((location) {
      print(location);
      sendMessage(context, docid, 'location', location.toString());
    });

    // } else {
    // print('No se seleccionó ninguna imagen.');
    // }
  }

  void getAudio(BuildContext context, docid) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );

    if (filePickerResult != null) {
      String url = await uploadFile(
        'audios/${filePickerResult.files.single.name}',
        File(filePickerResult.files.single.path!),
      );
      // ignore: use_build_context_synchronously
      sendMessage(context, docid, 'audio', url);
    } else {
      print('No se seleccionó ningún audio.');
    }
  }

  void getPdf(BuildContext context, docid) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (filePickerResult != null) {
      String url = await uploadFile(
        'pdfs/${filePickerResult.files.single.name}',
        File(filePickerResult.files.single.path!),
      );
      // ignore: use_build_context_synchronously
      sendMessage(context, docid, 'pdf', url);
    } else {
      print('No se seleccionó ningún PDF');
    }
  }

  Future<String> uploadFile(String path, File file) async {
    Reference reference = FirebaseStorage.instance.ref().child(path);
    UploadTask upladTask = reference.putFile(file);

    TaskSnapshot taskSnapshot = await upladTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
}
