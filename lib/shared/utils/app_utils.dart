import 'dart:math' as math;
import 'package:intl/intl.dart';

class AppUtils {
  // Format currency to Nepali Rupees
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: 'Rs. ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  // Format date to readable format
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  // Format date with time
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd MMM yyyy, hh:mm a');
    return formatter.format(dateTime);
  }

  // Format duration to readable format
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '$hours h ${minutes}m';
    } else if (minutes > 0) {
      return '$minutes m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // Calculate distance between two coordinates
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusKm = 6371;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadiusKm * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * 3.14159265359 / 180;
  }

  // Format distance to readable format
  static String formatDistance(double km) {
    if (km < 1) {
      return '${(km * 1000).toStringAsFixed(0)} m';
    } else if (km < 10) {
      return '${km.toStringAsFixed(1)} km';
    } else {
      return '${km.toStringAsFixed(0)} km';
    }
  }

  // Validate email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Validate phone number
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^[9][0-9]{9}$');
    return phoneRegex.hasMatch(phone);
  }

  // Get status color based on availability
  static String getAvailabilityStatus(int available, int total) {
    final percentage = (available / total) * 100;
    if (percentage > 50) {
      return 'Available';
    } else if (percentage > 20) {
      return 'Limited';
    } else {
      return 'Almost Full';
    }
  }

  // Calculate charging time estimate
  static String estimateChargingTime(double kwhNeeded, double chargerKw) {
    final hours = kwhNeeded / chargerKw;
    return '${hours.toStringAsFixed(1)} hours';
  }

  // Get rating description
  static String getRatingDescription(double rating) {
    if (rating >= 4.5) {
      return 'Excellent';
    } else if (rating >= 4.0) {
      return 'Very Good';
    } else if (rating >= 3.0) {
      return 'Good';
    } else if (rating >= 2.0) {
      return 'Fair';
    } else {
      return 'Poor';
    }
  }

  // Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Get initials from name
  static String getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }

  // Format kWh consumption
  static String formatKwh(double kwh) {
    return '${kwh.toStringAsFixed(2)} kWh';
  }

  // Calculate price based on consumption
  static double calculatePrice(double kwh, double pricePerKwh) {
    return kwh * pricePerKwh;
  }

  // Get charger type icon
  static String getChargerTypeEmoji(String type) {
    switch (type.toLowerCase()) {
      case 'fast':
        return '⚡';
      case 'ac':
        return '🔌';
      case 'dc':
        return '🔋';
      case 'slow':
        return '🐢';
      default:
        return '🔌';
    }
  }

  // Format review time
  static String formatReviewTime(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).toStringAsFixed(0)} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).toStringAsFixed(0)} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
