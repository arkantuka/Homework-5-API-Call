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

  void showData(choosed_game) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(
            '${choosed_game.name}',
            style: TextStyle(fontSize: 24.0),
          ),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('     Name : ${choosed_game.name}'),
                Text('     Genre : ' + choosed_game.genre.toString()),
                Text('     Developers : ' + choosed_game.developers.toString()),
                Text('     Publishers : ' + choosed_game.publishers.toString()),
                Text('     Release Dates: '),
                Text('        Japan: ' +
                    choosed_game.releaseDates["Japan"].toString()),
                Text('        NorthAmerica: ' +
                    choosed_game.releaseDates["NorthAmerica"].toString()),
                Text('        Europe: ' +
                    choosed_game.releaseDates["Europe"].toString()),
                Text('        Australia: ' +
                    choosed_game.releaseDates["Australia"].toString()),
              ],
            ),
          ),
        );
      },
    );
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
                        showData(game);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
