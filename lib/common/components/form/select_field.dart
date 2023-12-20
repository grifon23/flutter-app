import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/common/typing/option.dart';

class SelectControll extends StatefulWidget {
  const SelectControll({
    super.key,
    this.controller,
    required this.hintText,
    this.validator,
    required this.options,
    required this.value,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final String? value;
  final List<Option> options;

  @override
  State<SelectControll> createState() => _SelectControllState();
}

class _SelectControllState extends State<SelectControll> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          DropdownButtonFormField2<String>(
            value: widget.value,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
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
            ),
            hint: Text(
              widget.hintText,
              style: const TextStyle(fontSize: 14),
            ),
            items: widget.options
                .map((item) => DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            validator: widget.validator,
            onChanged: (value) {
              //Do something when selected item is changed.
              widget.controller?.text = value.toString();
            },
            onSaved: (value) {
              widget.controller?.text = value.toString();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              offset: Offset(0, 330),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
