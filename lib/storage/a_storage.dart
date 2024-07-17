abstract class AStorage {
  Future<void> init();
  Future<void> put<T>(String key, {T value});
  Future<void> delete(String key);
  Future<T?> get<T>(String key, {T? defaultValue});
  Future<void> flush();
  Future<void> close();
}