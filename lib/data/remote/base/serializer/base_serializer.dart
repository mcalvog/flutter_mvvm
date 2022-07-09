abstract class BaseSerializer<T> {
  T fromJson(Map<String, dynamic> data);
  Map<String, dynamic> toJson(T data);
}