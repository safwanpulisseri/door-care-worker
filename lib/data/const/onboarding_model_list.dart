import 'package:door_care_worker/data/model/onboarding_model.dart';
import 'package:door_care_worker/view/util/png_asset.dart';

final class OnboardingModelList {
  OnboardingModelList._();

  static const List<OnboardingModel> list = [
    OnboardingModel(
        image: AppPngPath.onboardOne,
        title: "Reliable Home\nServices at\nYour Fingertips",
        subtitle: "Plumbing, Electrical, and AC Repairs\nJust a Tap Away"),
    OnboardingModel(
        image: AppPngPath.onboardTwo,
        title: "Plumber & expert\nnearby you",
        subtitle: "Expert Plumbers Ready to Fix Leaks,\nClogs, and More."),
    OnboardingModel(
        image: AppPngPath.onboardThree,
        title: "Keep Your Home\nBright and Safe",
        subtitle: "Professional Electrical Services for\nAll Your Needs.")
  ];
}
