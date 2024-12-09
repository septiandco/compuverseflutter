class SignUpWithEmailAndPasswordFailure{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message ="An Unknown error Occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure("Please enter Stronger password");
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure("Email ist not valid ord badly formatted");
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure("An Account Already exist for that email");
      case 'operation-not_allowed':
        return const SignUpWithEmailAndPasswordFailure("Operation is not allowed");
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure("This user has been disabled.");
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}