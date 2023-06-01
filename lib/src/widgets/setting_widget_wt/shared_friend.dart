import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharedFriendsWidget extends StatelessWidget {
  const SharedFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.12,
      child: Center(
        child: ListTile(
          leading: const Icon(
            Icons.share_outlined,
            size: 35,
          ),
          title: const Text('Comparte con sus amigos'),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          onTap: () async {
            const url = 'https://play.google.com/store/apps/developer?id=bak_app';
            await Share.share(url);
          },
        ),
      ),
    );
  }
}
