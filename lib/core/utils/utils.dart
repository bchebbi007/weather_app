




import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../errors/failure/failure.dart';

///Map to left extension
extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return map(
          (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          debugPrint('mapLeftToFailure is :$e');
          debugPrint('obj is :$obj');
          throw obj;
        }
      }),
    );
  }
}