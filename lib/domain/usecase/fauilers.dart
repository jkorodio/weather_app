abstract class Fauilers {
  String errorMessage;
  Fauilers({required this.errorMessage});
}

class ServerError extends Fauilers {
  ServerError({required super.errorMessage});
}

class NetworkError extends Fauilers {
  NetworkError({required super.errorMessage});
}
