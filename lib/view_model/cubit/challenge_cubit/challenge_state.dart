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


///Challenges Questions
class GetChallengeDataLoadingState extends ChallengeState{}
class GetChallengeDataSuccessState extends ChallengeState{}
class GetChallengeDataErrorState extends ChallengeState{}

class GetNexQuizLoadingState extends ChallengeState{}
class GetNexQuizSuccessState extends ChallengeState{}
class GetNexQuizErrorState extends ChallengeState{}

class CheckAnsSuccessState extends ChallengeState{}

class QuizTimeState extends ChallengeState{}
class TimeUpState extends ChallengeState{}
class TimerStopState extends ChallengeState{}
