import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model.dart';
import 'controller.dart';

// ignore: must_be_immutable
class MyNote extends StatelessWidget {
  int index = 0;

  MyNote({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.find();
    String text = "";
    if (index == 0) {
      text = " ";
    } else {
      text = nc.notes[index].title;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: index == 0
                  ? const Text('Create a New Note')
                  : const Text('Update Note'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Create a New Note',
                          labelText: ' Update Note',
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        style: const TextStyle(fontSize: 20),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (index == 0) {
                                nc.notes.add(
                                    Note(title: textEditingController.text));
                              } else {
                                var updatenote = nc.notes[index];
                                updatenote.title = textEditingController.text;
                                nc.notes[index] = updatenote;
                              }
                              Get.back();
                            },
                            child: index == 0
                                ? const Text('Add')
                                : const Text('Update'),
                          )
                        ])
                  ],
                ),
              ),
            )));
  }
}
