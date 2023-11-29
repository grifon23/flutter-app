import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/projects/screens/project-detail.screen.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final String firstLetter;
  final String id;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.firstLetter,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: InkWell(
          splashColor: const Color.fromARGB(255, 255, 255, 227),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: ProjectDetailScreen(projectId: id, name: projectName),
                type: PageTransitionType.theme,
                duration: const Duration(milliseconds: 700),
              ),
            );
          },
          child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.yellowAccent,
                      child: Text(
                        firstLetter,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      projectName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Expanded(
                      child: Text(''),
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      size: 24,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
