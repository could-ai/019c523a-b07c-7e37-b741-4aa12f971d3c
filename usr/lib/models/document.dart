import 'package:flutter/material.dart';

enum FileType { pdf, image, doc, other }

class Document {
  final String id;
  final String title;
  final String category;
  final DateTime dateAdded;
  final String fileSize;
  final FileType fileType;
  final String? description;

  Document({
    required this.id,
    required this.title,
    required this.category,
    required this.dateAdded,
    required this.fileSize,
    required this.fileType,
    this.description,
  });

  IconData get icon {
    switch (fileType) {
      case FileType.pdf:
        return Icons.picture_as_pdf;
      case FileType.image:
        return Icons.image;
      case FileType.doc:
        return Icons.description;
      case FileType.other:
      default:
        return Icons.insert_drive_file;
    }
  }

  Color get color {
    switch (fileType) {
      case FileType.pdf:
        return Colors.red;
      case FileType.image:
        return Colors.purple;
      case FileType.doc:
        return Colors.blue;
      case FileType.other:
      default:
        return Colors.grey;
    }
  }
}
