import 'package:flutter/material.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/common/components/tags/base_tags.dart';

import '../utils/user_positions.dart';
import '../utils/user_role.dart';

class PreviewAccount extends StatelessWidget {
  const PreviewAccount({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
          child: Column(
        children: [
          Container(
              child: user.avatarUrl != null
                  ? Image.network(
                      user.avatarUrl!,
                      height: 160.0,
                      width: 160.0,
                    )
                  : const Icon(
                      Icons.account_circle,
                      size: 160.0,
                    )),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${user.name} ${user.lastName}',
            style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
          ),
        ],
      )),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              const Text('Position: '),
              Text(
                Positions.positionsLabel[user.positions?[0]] ?? 'unknow',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Email: '),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Account type: '),
              Text(UserRoles.rolesLabel[user.role!] ?? 'unknow',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Date of birth: '),
              Text(user.birthDate ?? '00/00/0000',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Start of cooperation: '),
              Text(user.cooperationStartDate ?? '00/00/0000',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Technologies: '),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260.0),
                child: (user.technologies != null)
                    ? Wrap(
                        children: [
                          if (user.technologies != null)
                            ...user.technologies!.map((it) => BaseTag(tag: it))
                        ],
                      )
                    : Text('none technologies'),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      )
    ]);
  }
}
