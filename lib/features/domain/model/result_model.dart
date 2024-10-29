import 'package:equatable/equatable.dart';

class ResultModel<T> extends Equatable {
  final bool isSuccess;
  final bool isNoData;
  final String message;
  final T? data;

  const ResultModel({
    this.isSuccess = false,
    this.isNoData = false,
    this.message = "",
    this.data,
  });

  @override
  List<Object?> get props => [
        isSuccess,
        isNoData,
        message,
        data,
      ];
}
