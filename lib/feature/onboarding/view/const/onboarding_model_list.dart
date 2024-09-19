import '../model/onboarding_model.dart';
import '../../../../core/util/png_asset.dart';

final class OnboardingModelList {
  OnboardingModelList._();

  static const List<OnboardingModel> list = [
    OnboardingModel(
      image: AppPngPath.onboardOne,
      title: "Maximize Your\nEarnings",
      subtitle:
          "Discover high-paying jobs in your area\ntailored to your skills. Join Door Care and\ntart maximizing your earnings today!",
    ),
    OnboardingModel(
      image: AppPngPath.onboardTwo,
      title: "Flexible\nScheduling",
      subtitle:
          "Work when you want, where you want. With\nDoor Care, you have the freedom to choose\njobs that fit your schedule and location\npreferences.",
    ),
    OnboardingModel(
      image: AppPngPath.onboardThree,
      title: "Growth and\nSupport",
      subtitle:
          "Join a community that values your expertise\nand supports your professional growth. At\nDoor Care, we’re committed to helping you\nachieve success and satisfaction in your\ncareer.",
    ),
  ];
}
