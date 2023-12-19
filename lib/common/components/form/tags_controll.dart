import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_tag_editor/tag_editor.dart';

class TagsControll extends StatefulWidget {
  TagsControll({
    Key? key,
    required this.hintText,
    required this.tags,
    required this.isError,
    this.title,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final String? title;
  final List<String> tags;
  final bool isError;

  @override
  State<TagsControll> createState() => _TagsControllState();
}

class _TagsControllState extends State<TagsControll> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  _onDelete(index) {
    setState(() {
      widget.tags.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TagEditor(
            length: widget.tags.length,
            controller: _textEditingController,
            focusNode: _focusNode,
            delimiters: [',', ' '],
            hasAddButton: false,
            resetTextOnSubmitted: true,

            textStyle: const TextStyle(color: Colors.grey),
            onSubmitted: (outstandingValue) {
              // setState(() {
              //   widget.tags.add(outstandingValue);
              // });
            },
            minTextFieldWidth: 350.0,
            inputDecoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey.shade500)),
            onTagChanged: (newValue) {
              setState(() {
                widget.tags.add(newValue);
              });
            },
            tagBuilder: (context, index) => _Chip(
              index: index,
              label: widget.tags[index],
              onDeleted: _onDelete,
            ),
            // InputFormatters example, this disallow \ and /

            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
            ],
          ),
          Visibility(
            visible: widget.isError,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Field is requre',
                    style: TextStyle(
                      color: Color.fromARGB(255, 163, 16, 16),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
