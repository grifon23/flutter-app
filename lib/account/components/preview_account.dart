import 'package:flutter/material.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/common/components/tags/base_tags.dart';

import '../../common/components/image/avatar_image.dart';
import '../utils/user_positions.dart';
import '../utils/user_role.dart';
import 'setting_row.dart';

class PreviewAccount extends StatelessWidget {
  const PreviewAccount({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
          child: Column(
        children: [
          AvatarImage(
            url: user.avatarUrl,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${user.name} ${user.lastName}',
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
            ),
          )
        ],
      )),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SettingRow(
            label: 'Position',
            value: Positions.positionsLabel[user.positions] ?? 'unknow',
          ),
          const SizedBox(
            height: 10,
          ),
          SettingRow(
            label: 'Email',
            value: user.email,
          ),
          const SizedBox(
            height: 10,
          ),
          SettingRow(
            label: 'Account type',
            value: UserRoles.rolesLabel[user.role!] ?? 'unknow',
          ),
          const SizedBox(
            height: 10,
          ),
          SettingRow(
            label: 'Date of birth',
            value: user.birthDate ?? '00/00/0000',
          ),
          const SizedBox(
            height: 10,
          ),
          SettingRow(
            label: 'Start of cooperation',
            value: user.cooperationStartDate ?? '00/00/0000',
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
