// ignore_for_file: use_build_context_synchronously

import 'package:dicoding_simple_local_storage/data/model/note.dart';
import 'package:dicoding_simple_local_storage/data/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteAddUpdatePage extends StatefulWidget {
  const NoteAddUpdatePage({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<NoteAddUpdatePage> createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
      _isUpdate = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Simpan'),
                onPressed: () async {
                  if (!_isUpdate) {
                    final note = Note(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    await Provider.of<DbProvider>(context, listen: false)
                        .addNote(note);
                  } else {
                    final note = Note(
                      id: widget.note!.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    await Provider.of<DbProvider>(context, listen: false)
                        .updateNote(note);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
