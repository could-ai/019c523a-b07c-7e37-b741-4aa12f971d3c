import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/document.dart';
import '../providers/document_provider.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  FileType _selectedType = FileType.pdf;
  bool _isFileSelected = false;

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveDocument() {
    if (_formKey.currentState!.validate()) {
      if (!_isFileSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a file (simulated)')),
        );
        return;
      }

      final newDoc = Document(
        id: DateTime.now().toString(),
        title: _titleController.text,
        category: _categoryController.text.isEmpty ? 'Uncategorized' : _categoryController.text,
        dateAdded: DateTime.now(),
        fileSize: '1.5 MB', // Mocked
        fileType: _selectedType,
        description: _descriptionController.text,
      );

      Provider.of<DocumentProvider>(context, listen: false).addDocument(newDoc);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Document'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // File Upload Simulation Area
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isFileSelected = true;
                  });
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: _isFileSelected ? Colors.green.shade50 : Colors.grey.shade100,
                    border: Border.all(
                      color: _isFileSelected ? Colors.green : Colors.grey.shade400,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isFileSelected ? Icons.check_circle : Icons.cloud_upload,
                        size: 48,
                        color: _isFileSelected ? Colors.green : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isFileSelected ? 'File Selected' : 'Tap to Upload File',
                        style: TextStyle(
                          color: _isFileSelected ? Colors.green : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category (e.g., Work, Personal)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<FileType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'File Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.type_specimen),
                ),
                items: FileType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _saveDocument,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Document',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
