import 'package:flutter_starter/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

class NoParams {}
