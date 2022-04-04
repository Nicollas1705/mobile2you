import 'package:flutter_test/flutter_test.dart';
import 'package:mobile2you/shared/utils/like_count.dart';

void main() {
  test(
    "Should test the like count method",
    () {
      final map = {
        -10: "No Like",
        0: "No Like",
        1: "1 Like",
        8: "8 Likes",
        100: "100 Likes",
        999: "999 Likes",
        4000: "4K Likes",
        4999: "4,9K Likes",
        6500: "6,5K Likes",
        8923: "8,9K Likes",
        11239: "11,2K Likes",
        99999: "99,9K Likes",
        324324: "324K Likes",
        2300001: "2,3M Likes",
        1234567: "1,2M Likes",
        87654321: "87,6M Likes",
        987654321: "987M Likes",
        1987654321: "1B Likes",
        21987654321: "21B Likes",
        321987654321: "321B Likes",
      };

      map.forEach((key, value) {
        final result = LikeCount.getText(key);
        expect(result == value, true);
      });
    },
  );
}
