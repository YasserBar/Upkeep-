part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginCustomerEvent extends AuthEvent {
  
  final Login login;

  final bool rememberMe;
  const LoginCustomerEvent(this.login, this.rememberMe);

  @override
  List<Object> get props => [login, rememberMe];
}
class LoginProviderEvent extends AuthEvent {
  
  final Login login;

  final bool rememberMe;
  const LoginProviderEvent(this.login, this.rememberMe);

  @override
  List<Object> get props => [login, rememberMe];
}

class SignupEvent extends AuthEvent {
  final Signup signup;

  const SignupEvent(this.signup);

  @override
  List<Object> get props => [signup];
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  const ForgetPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ResendPinEvent extends AuthEvent {
  final String email;

  const ResendPinEvent(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyPinForgetEvent extends AuthEvent {
  final VerifyPinForget verifyPinForget;
  final bool rememberMe;
  const VerifyPinForgetEvent(this.verifyPinForget, this.rememberMe);

  @override
  List<Object> get props => [verifyPinForget, rememberMe];
}

class VerifyPinSignupEvent extends AuthEvent {
  final VerifyPinSignup verifyPinSignup;
  final bool rememberMe;
  const VerifyPinSignupEvent(this.verifyPinSignup, this.rememberMe);

  @override
  List<Object> get props => [verifyPinSignup, rememberMe];
}
