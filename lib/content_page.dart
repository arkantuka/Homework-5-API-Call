import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homework_5/game_model.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<Game>? _games;

  void _getGameInfo() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response =
        await dio.get('https://api.sampleapis.com/playstation/games');
    List list = jsonDecode(response.data.toString());
    setState(() {
      _games = list.map((e) => Game.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _games == null
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: _games!.length,
                  itemBuilder: (context, index) {
                    var game = _games![index];
                    return ListTile(
                      title: Text(game.name ?? ''),
                      subtitle: Text('Creator : ' + game.developers.toString()),
                      onTap: () {
                        print('${game.name}');
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
