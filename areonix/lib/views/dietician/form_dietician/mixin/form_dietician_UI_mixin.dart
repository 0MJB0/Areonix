import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:expansion_tile_list/expansion_tile_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../splash_dietician/provider/dietican_provider.dart';
import '../provider/form_dietician_provider.dart';
import 'form_dietician_mixin.dart';

mixin FormDieticianUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, FormDieticianMixin<T> {
  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 65),
      child: SafeArea(
        child: CustomSearchBar(
          backIcon: Icons.add_circle,
          backIconColor: TColor.airforce,
          title: StringConstants.formDieticianTitle,
          onSearchChanged: (query) {
            ref.read(formDieticianProvider.notifier).filterForms(query);
          },
          onSearchCancelled: () {
            ref.read(formDieticianProvider.notifier).filterForms('');
          },
          searchTextController: searchController,
          padding: context.padding.horizontalNormal,
          onBackIconPressed: () {
            searchController.clear();
            context.route.navigateName(RouteConstant.createFormDietician);
          },
        ),
      ),
    );
  }

  Widget formCard(BuildContext context, WidgetRef ref) {
    final formListState = ref.watch(formDieticianProvider);
    final formsToShow = formListState.searchingForms
        ? formListState.filteredForms ?? []
        : formListState.forms;

    return SizedBox(
      width: kIsWeb
          ? Responsiveness.formCardWeb.w
          : Responsiveness.formCardMobile.w,
      child: Padding(
        padding: context.padding.onlyTopMedium,
        child: ExpansionTileList(
          tileGapSize: 10,
          children: formsToShow.map<ExpansionTile>((form) {
            return ExpansionTile(
              title: WebText(
                text: form.formName ?? '',
                textStyle: context.general.textTheme.bodyLarge?.copyWith(
                  color: TColor.white,
                ),
              ),
              backgroundColor: TColor.airforce,
              collapsedBackgroundColor: TColor.airforce,
              iconColor: TColor.white,
              collapsedIconColor: TColor.white,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () => context.route.navigateName(
                        RouteConstant.editFormDietician,
                        data: form,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        final dieticianId = ref.read(dieticianProvider).id;
                        if (dieticianId != null) {
                          showDeleteDialog(
                            context,
                            form.formName ?? '',
                            dieticianId,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
