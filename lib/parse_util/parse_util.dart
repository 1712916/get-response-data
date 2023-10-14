import 'dart:developer';

import 'package:intl/intl.dart';

extension ParseUtilInt on dynamic {
  int? get parseInt {
    return int.tryParse(toString());
  }
}

extension ParseUtilDouble on dynamic {
  double? get parseDouble {
    return double.tryParse(toString());
  }
}

extension ParseUtilBool on dynamic {
  ////can be custom with TRUE, FALSE, YES or NO...
  bool? get parseBool {
    if (this == 1) {
      return true;
    } else if (this == 0) {
      return false;
    }

    return bool.tryParse(toString());
  }
}

extension ParseUtilList on dynamic {
  ////can be custom with TRUE, FALSE, YES or NO...
  List<T>? parseList<T>(T Function(dynamic) parseItem) {
    try {
      if (this is List) {
        return (this as List).map<T>((e) => parseItem(e)).toList();
      }
    } catch (e, stackTrace) {
      log('parse list ${T.runtimeType} error: ', error: e, stackTrace: stackTrace);
    }

    return null;
  }
}

extension ParseUtilDate on dynamic {
  ///DateTime.parse in dart have a special format to parse
  ///check list format in this link
  ///https://api.flutter.dev/flutter/dart-core/DateTime/parse.html

  ///pattern follow by this link
  ///https://api.flutter.dev/flutter/intl/DateFormat-class.html
  ///this function have some restricts,
  ///it auto parse successfully with several cases but it wrong with expect
  DateTime? parseDate(String pattern) {
    try {
      return DateFormat(pattern).parse(this!.toString());
    } catch (_) {
      return null;
    }
  }

  ///default is seconds
  ///should * 1000
  DateTime? get parseDateByTimeStamp {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this.parseInt() * 1000);
    } catch (_) {}
    return null;
  }
}
