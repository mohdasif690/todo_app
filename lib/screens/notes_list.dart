import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/my_note.dart';
import 'my_note.dart';
import 'controller.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        // ignore: prefer_is_empty
        () => nc.notes.length == 0
            ? Center(
                child: Image.asset('assets/lists.jpeg'),
              )
            : ListView.builder(
                itemCount: nc.notes.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          title: Text(nc.notes[index].title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          leading: Text(
                            (index + 1).toString() + ".",
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: Wrap(children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.create),
                                onPressed: () => Get.to(MyNote(index: index))),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Delete Note',
                                      middleText: nc.notes[index].title,
                                      onCancel: () => Get.back(),
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        nc.notes.removeAt(index);
                                        Get.back();
                                      });
                                })
                          ])),
                    )),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Todo App'),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Get.to(MyNote(
                  index: 0,
                ));
              },
            ),
            // ignore: avoid_unnecessary_containers
            body: Container(
              child: Padding(
                  padding: const EdgeInsets.all(5), child: getNoteList()),
            )));
  }
}
