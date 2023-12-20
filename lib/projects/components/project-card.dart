import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/root/navigation/routes_names.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final String firstLetter;
  final String id;
  final String? imgUrl;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.firstLetter,
    required this.id,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 232, 232, 232), Colors.white],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 3),
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          onTap: () => context.goNamed(UserStack.ProjectDetail,
              pathParameters: {'id': id},
              queryParameters: {'projectName': projectName}),
          title: Text(
            projectName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          leading: imgUrl != null
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl!,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.yellowAccent,
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
          trailing: const Icon(
            Icons.arrow_forward_outlined,
            size: 24,
          ),
        ),
      ),
    );
  }
}
