// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cover_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieCoverController on MovieCoverControllerBase, Store {
  final _$likedAtom = Atom(name: 'MovieCoverControllerBase.liked');

  @override
  bool get liked {
    _$likedAtom.reportRead();
    return super.liked;
  }

  @override
  set liked(bool value) {
    _$likedAtom.reportWrite(value, super.liked, () {
      super.liked = value;
    });
  }

  final _$MovieCoverControllerBaseActionController =
      ActionController(name: 'MovieCoverControllerBase');

  @override
  void likeChanger() {
    final _$actionInfo = _$MovieCoverControllerBaseActionController.startAction(
        name: 'MovieCoverControllerBase.likeChanger');
    try {
      return super.likeChanger();
    } finally {
      _$MovieCoverControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
liked: ${liked}
    ''';
  }
}
