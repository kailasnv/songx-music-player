import 'package:flutter/material.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text("song name"),
          subtitle: Text("kailax"),
        );
      },
    );
  }
}
