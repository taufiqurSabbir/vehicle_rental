// status_utils.dart
import 'package:flutter/material.dart';

IconData getStatusIcon(String? status) {
  switch (status?.toLowerCase()) {
    case 'available':
      return Icons.check_circle;
    case 'running':
      return Icons.directions_bike;
    default:
      return Icons.cancel;
  }
}

Color getStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'available':
      return Colors.green;
    case 'running':
      return Colors.orange;
    default:
      return Colors.red;
  }
}

String getStatusText(String? status) {
  switch (status?.toLowerCase()) {
    case 'available':
      return 'Available';
    case 'running':
      return 'Running';
    default:
      return 'Unavailable';
  }
}
