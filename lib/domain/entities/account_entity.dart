import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String token;

  AccountEntity(this.token);

  List<Object> get props => [token];
}
