abstract class ChallengeState{}

class ChallengeInitState extends ChallengeState{}

class NoInternetConnectionState extends ChallengeState{}


class SignInAnonymouslyLoadingState extends ChallengeState{}
class SignInAnonymouslySuccessState extends ChallengeState{}
class SignInAnonymouslyErrorState extends ChallengeState{}

class SignOutAnonymouslyLoadingState extends ChallengeState{}
class SignOutAnonymouslySuccessState extends ChallengeState{}
class SignOutAnonymouslyErrorState extends ChallengeState{}

class CreateUserDataLoadingState extends ChallengeState{}
class CreateUserDataSuccessState extends ChallengeState{}
class CreateUserDataErrorState extends ChallengeState{}

class GetUserDataLoadingState extends ChallengeState{}
class GetUserDataSuccessState extends ChallengeState{}
class GetUserDataErrorState extends ChallengeState{}