abstract class Fauilers {
  String ErrorMessage;
  Fauilers({required this.ErrorMessage});
}

class ServerError extends Fauilers {
  ServerError({required super.ErrorMessage});
}

class NetworkError extends Fauilers {
  NetworkError({required super.ErrorMessage});
}
