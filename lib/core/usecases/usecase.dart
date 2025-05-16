abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

// For use cases that don't require parameters
class NoParams {}
