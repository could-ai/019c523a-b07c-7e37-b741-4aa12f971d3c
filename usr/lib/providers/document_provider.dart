import 'package:flutter/material.dart';
import '../models/document.dart';

class DocumentProvider with ChangeNotifier {
  final List<Document> _documents = [
    Document(
      id: '1',
      title: 'Project Proposal',
      category: 'Work',
      dateAdded: DateTime.now().subtract(const Duration(days: 2)),
      fileSize: '2.4 MB',
      fileType: FileType.pdf,
      description: 'Proposal for the new client project Q3.',
    ),
    Document(
      id: '2',
      title: 'ID Card Scan',
      category: 'Personal',
      dateAdded: DateTime.now().subtract(const Duration(days: 5)),
      fileSize: '1.2 MB',
      fileType: FileType.image,
      description: 'Scanned copy of National ID.',
    ),
    Document(
      id: '3',
      title: 'Invoice #0045',
      category: 'Finance',
      dateAdded: DateTime.now().subtract(const Duration(days: 1)),
      fileSize: '0.5 MB',
      fileType: FileType.pdf,
    ),
    Document(
      id: '4',
      title: 'Meeting Notes',
      category: 'Work',
      dateAdded: DateTime.now().subtract(const Duration(hours: 4)),
      fileSize: '15 KB',
      fileType: FileType.doc,
    ),
  ];

  List<Document> get documents => [..._documents];

  void addDocument(Document doc) {
    _documents.insert(0, doc);
    notifyListeners();
  }

  void deleteDocument(String id) {
    _documents.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  List<Document> searchDocuments(String query) {
    if (query.isEmpty) return documents;
    return _documents.where((doc) {
      return doc.title.toLowerCase().contains(query.toLowerCase()) ||
             doc.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
