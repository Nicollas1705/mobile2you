abstract class LikeCount {
  static String getText(
    int quantity, {
    String like = "Like",
    String likes = "Likes",
  }) {
    if (quantity <= 0) {
      return "No $like";
    } else if (quantity == 1) {
      return "1 $like";
    } else if (quantity < 1000) {
      // 1 000
      return "$quantity $likes";
    } else if (quantity < 100000) {
      // 100 000
      String thousend = "${quantity ~/ 1000}";
      String hundred = "${(quantity ~/ 100) % 10}";
      if (int.parse(hundred) == 0) {
        return "${thousend}K $likes";
      }
      return "$thousend,${hundred}K $likes";
    } else if (quantity < 1000000) {
      // 1 000 000
      String thousend = "${quantity ~/ 1000}";
      return "${thousend}K $likes";
    } else if (quantity < 100000000) {
      // 100 000 000
      String milion = "${quantity ~/ 1000000}";
      String thousend = "${(quantity ~/ 100000) % 10}";
      if (int.parse(thousend) == 0) {
        return "${milion}M $likes";
      }
      return "$milion,${thousend}M $likes";
    } else if (quantity < 1000000000) {
      // 1 000 000 000
      String milion = "${quantity ~/ 1000000}";
      return "${milion}M $likes";
    } else {
      String bilion = "${quantity ~/ 1000000000}";
      return "${bilion}B $likes";
    }
  }
}
