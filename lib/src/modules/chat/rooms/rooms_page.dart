import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/chats/chat_page.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/room_controller.dart';
import 'package:projetos_flutter_dio/src/shared/custom_text_form_field.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_button.dart';

class RoomsPage extends StatefulWidget {
  final String title;
  final String username;

  const RoomsPage({super.key, required this.title, required this.username});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _roomController = di<RoomController>();
  final roomNameEC = TextEditingController();
  bool canCreate = true;

  @override
  void initState() {
    super.initState();
    _roomController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: const [
          DarkModeButton(),
        ],
      ),
      floatingActionButton: canCreate
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Criar nova sala'),
                    content: SizedBox(
                      width: 200,
                      child: CustomTextField(
                        controller: roomNameEC,
                        label: 'Qual nome da sala?',
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton.filled(
                        onPressed: () async {
                          var roomName = roomNameEC.text.trim();
                          _roomController.createRoom(
                            roomName,
                            widget.username,
                          );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: StreamBuilder(
        stream: _roomController.listen(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nenhuma sala criada. Crie a primeira!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomTextField(
                        controller: roomNameEC,
                        label: 'Qual nome da sala?',
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton.filled(
                      onPressed: () async {
                        var roomName = roomNameEC.text.trim();
                        _roomController.createRoom(
                          roomName,
                          widget.username,
                        );
                      },
                      icon: const Icon(Icons.check),
                    )
                  ],
                ),
              ],
            ));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              children: snapshot.data!.docs.map(
                (e) {
                  // var roomModel =
                  //     RoomModel.fromJson((e.data() as Map<String, dynamic>));
                  String roomName =
                      (e.data() as Map<String, dynamic>)['room_name'];
                  String? roomId =
                      (e.data() as Map<String, dynamic>)['room_id'].toString();
                  roomName = roomName.substring(6);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(roomName),
                        leading: Text(roomId),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              title: roomName,
                              username: widget.username,
                              room: roomName,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ).toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
