import 'package:get_response_data/parse_util/parse_util.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'parse bool',
    () {
      test(
        'parse from true string should be true',
        () {
          final actual = 'true'.parseBool;

          final matcher = true;

          expect(actual, matcher);
        },
      );

      test(
        'parse from false string should be false',
        () {
          final actual = 'false'.parseBool;

          final matcher = false;

          expect(actual, matcher);
        },
      );

      test(
        'parse from empty string should be false',
        () {
          final actual = 'false'.parseBool;

          final matcher = false;

          expect(actual, matcher);
        },
      );

      test(
        'parse from 1 should be true',
        () {
          final actual = 1.parseBool;

          final matcher = true;

          expect(actual, matcher);
        },
      );

      test(
        'parse from 0 should be false',
        () {
          final actual = 0.parseBool;

          final matcher = false;

          expect(actual, matcher);
        },
      );

      test(
        'parse from true should be true',
        () {
          final actual = true.parseBool;

          final matcher = true;

          expect(actual, matcher);
        },
      );

      test(
        'parse from false should be false',
        () {
          final actual = false.parseBool;

          final matcher = false;

          expect(actual, matcher);
        },
      );
    },
  );

  group(
    'parse int',
    () {
      test(
        'parse from valid int: int',
        () {
          final actual = 0.parseInt;

          final matcher = 0;

          expect(actual, matcher);
        },
      );

      test(
        'parse from valid int: String',
        () {
          final actual = '0'.parseInt;

          final matcher = 0;

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid int: double',
        () {
          final actual = (1.0).parseInt;

          final matcher = null;

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid int: bool',
        () {
          final actual = (false).parseInt;

          final matcher = null;

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid int: String',
        () {
          final actual = ('invalid_string').parseInt;

          final matcher = null;

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid int: max value (64 bit) + 1 by String',
        () {
          final actual = ('9223372036854775808').parseInt;

          final matcher = null;

          expect(actual, matcher);
        },
      );
    },
  );

  group(
    'parse date',
    () {
      test(
        'parse from valid format',
        () {
          final actual = '15-12-1999'.parseDate('dd-MM-yyyy');

          final matcher = DateTime(1999, 12, 15);

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid format',
        () {
          final actual = 'invalid_format'.parseDate('dd-MM-yyyy');

          final matcher = null;

          expect(actual, matcher);
        },
      );

      test(
        'parse from invalid format',
        () {
          final actual = '15-12-1999'.parseDate('invalid_format');

          final matcher = null;

          expect(actual, matcher);
        },
      );
    },
  );

  group('parse list', () {
    test('parse valid list', () {
      final actual = [1, 2, 3, 4].parseList((p0) => p0);

      final matcher = [1, 2, 3, 4];

      expect(actual, matcher);
    });

    test('parse valid json list', () {
      final actual = [
        {
          'nameKey': 'nameValue',
        }
      ].parseList((p0) => p0);

      final matcher = [
        {
          'nameKey': 'nameValue',
        }
      ];

      expect(actual, matcher);
    });

    test('parse valid json list to user entity list', () {
      final actual = [
        {
          'name': 'vinh ngo',
          'age': 24,
        }
      ].parseList<UserEntity>((p0) {
        if (p0 is Map) {
          return UserEntity.fromJson(p0);
        }

        ///throw exception
        ///or return default entity
        return UserEntity(name: 'default name', age: 0);
      }).toString();

      final matcher = [
        UserEntity(
          name: 'vinh ngo',
          age: 24,
        ),
      ].toString();

      expect(actual, matcher);
    });

    test('parse invalid list', () {
      final actual = '[0,1,2,3,4]'.parseList((p0) => p0);

      final matcher = null;

      expect(actual, matcher);
    });
  });
}

class UserEntity {
  final String name;
  final int age;

  factory UserEntity.fromJson(Map json) {
    final age = json['age'];
    return UserEntity(
      name: json['name'].toString(),
      age: age != null ? age.parseInt : 0,
      // age: json['age'].toString().parseInt ?? 0,

      ///<- not good for memory
      ///age: json['age'].parseInt ?? 0, <- this line throw exception
    );
  }

  const UserEntity({
    required this.name,
    required this.age,
  });

  @override
  String toString() {
    return '$runtimeType: ${toMap().toString()}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }
}
