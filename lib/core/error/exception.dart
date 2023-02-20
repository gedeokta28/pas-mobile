class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException(this.message);
}
