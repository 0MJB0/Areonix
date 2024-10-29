import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/constants/string/success_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/form_client/mixin/form_client_mixin.dart';
import 'package:areonix/views/client/form_client/provider/form_client_provider.dart';
import 'package:areonix/views/client/splash_client/provider/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

mixin FormClientUIMixin<T extends ConsumerStatefulWidget>
    on FormClientMixin<T> {
  int currentIndex = 0; // Track the current index in the PageView
  bool _isTitleUpdated = false; // To avoid multiple title updates

  // AppBar with dynamic title
  ClientAppbar appBar(BuildContext context, WidgetRef ref) {
    final formTitle = ref.watch(informationMemberTitleProvider);
    return ClientAppbar(
      title: formTitle,
    );
  }

  Widget pageView(WidgetRef ref) {
    final clientState = ref.watch(clientProvider);
    final dieticianForms = clientState.dieticianForms;
    final submittedForms = clientState.isFormSubmitted ?? <String, bool>{};

    final availableForms = dieticianForms?.keys.where((formName) {
          final isSubmitted = submittedForms[formName] ?? false;
          return !isSubmitted;
        }).toList() ??
        [];

    // Check if there are no available forms
    if (availableForms.isEmpty) {
      // Defer setting the default title until after build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isTitleUpdated) {
          ref.read(informationMemberTitleProvider.notifier).resetTitle();
          _isTitleUpdated = true; // Ensure this only runs once
        }
      });

      return const ClientInfoCard(
        message: StringConstants.informationSplashCardText,
      );
    }

    // Call updateTitle with the first form's name initially
    if (availableForms.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isTitleUpdated) {
          ref
              .read(informationMemberTitleProvider.notifier)
              .updateTitle(availableForms[currentIndex]);
          _isTitleUpdated = true; // Ensure this only runs once
        }
      });
    }

    return Stack(
      children: [
        Column(
          children: [
            context.sized.emptySizedHeightBoxNormal,
            // Page Indicator
            Padding(
              padding: context.padding.low,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: availableForms.length,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: TColor.airforce,
                    dotColor: TColor.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: availableForms.length,
                onPageChanged: (index) {
                  currentIndex = index;
                  ref.read(informationMemberTitleProvider.notifier).updateTitle(
                        availableForms[index],
                      );
                },
                itemBuilder: (context, index) {
                  final currentForm = availableForms[index];
                  final formQuestions = dieticianForms![currentForm] ?? [];
                  final formControllers = List.generate(
                    formQuestions.length,
                    (index) => TextEditingController(),
                  );

                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: context.padding.high,
                      child: Column(
                        children: [
                          ...List.generate(formQuestions.length, (index) {
                            return Padding(
                              padding: context.padding.verticalLow,
                              child: SizedBox(
                                width:
                                    Responsiveness.formClientTextfieldMobile.w,
                                child: MemberTextField(
                                  description: formQuestions[index],
                                  controller: formControllers[index],
                                  errorTextColor: TColor.black,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ErrorConstants
                                          .informationEmptyAlert;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            );
                          }),
                          context.sized.emptySizedHeightBoxNormal,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child:
              buildSendFormButton(ref, context, availableForms[currentIndex]),
        ),
      ],
    );
  }

  Widget buildSendFormButton(
      WidgetRef ref, BuildContext context, String currentForm) {
    return Container(
      padding: context.padding.normal,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColor.airforce,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final currentClientState = ref.read(clientProvider);
          final formControllers = List.generate(
            ref.read(clientProvider).dieticianForms![currentForm]?.length ?? 0,
            (index) => TextEditingController(),
          );

          if (formKey.currentState?.validate() ?? false) {
            final responses = <String, String>{};

            // Gather form responses
            for (var i = 0; i < formControllers.length; i++) {
              responses[currentClientState.dieticianForms![currentForm]![i]] =
                  formControllers[i].text;
            }

            try {
              // Update the responses state with new responses
              ref.read(clientProvider.notifier).updateResponses(
                    currentClientState.clientID!,
                    currentForm, // Pass the form name
                    responses,
                  );

              // Update submission state after successful save
              ref
                  .read(clientProvider.notifier)
                  .updateFormSubmissionState(currentForm, true);

              // Immediately re-fetch the updated state after submission
              final updatedClientState = ref.read(clientProvider);
              final dieticianForms = updatedClientState.dieticianForms;
              final submittedForms =
                  updatedClientState.isFormSubmitted ?? <String, bool>{};
              final remainingForms = dieticianForms?.keys.where((formName) {
                    final isSubmitted = submittedForms[formName] ?? false;
                    return !isSubmitted;
                  }).toList() ??
                  [];

              // Check the status of remaining forms and reset title if needed
              if (remainingForms.isEmpty) {
                // Reset the title if all forms have been submitted
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(informationMemberTitleProvider.notifier)
                      .resetTitle();
                });
              }

              showCustomSnackBar(
                context: context,
                message: SuccessConstants.informationSuccess,
              );
            } catch (e) {
              showErrorSnackBar(context, e);
            }
          } else {
            showCustomSnackBar(
              context: context,
              message: StringConstants.informationFillAll,
            );
          }
        },
        child: BoldText(
          text: StringConstants.informationSendButton,
          color: TColor.white,
        ),
      ),
    );
  }
}
