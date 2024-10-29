class SuccessModel<T> {
  final String message;
  final T? data;

  const SuccessModel({
    this.message = "",
    this.data,
  });
}
