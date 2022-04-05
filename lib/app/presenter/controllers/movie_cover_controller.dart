import 'package:mobx/mobx.dart';
part 'movie_cover_controller.g.dart';

class MovieCoverController = MovieCoverControllerBase with _$MovieCoverController;

abstract class MovieCoverControllerBase with Store {
  @observable
  bool liked = false;

  @action
  void likeChanger() => liked = !liked;
}
