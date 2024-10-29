class FailedModel<T> {
  final String message;
  final T? data;

  const FailedModel({
    this.message = "",
    this.data,
  });
}
