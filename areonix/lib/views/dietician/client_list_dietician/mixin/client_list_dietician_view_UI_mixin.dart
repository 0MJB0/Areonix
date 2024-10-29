import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
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
import '../provider/client_list_dietician_provider.dart';
import 'client_list_dietician_mixin.dart';

mixin ClientListDieticianViewUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, ClientListDieticianMixin<T> {
  void showAddClientDialog(BuildContext context) {
    final clients = ref.read(clientListDieticianProvider).clients;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AddClientDialog(
          idController: idController,
          clients: clients.map((c) => c.clientId!).toList(),
          onUpdate: () {
            final clientId = idController.text;

            ref
                .read(clientListDieticianProvider.notifier)
                .addClient(clientId, context, ref);
          },
        );
      },
    ).then((_) {
      idController.clear();
    });
  }

  void showFormUploadDialog(
    BuildContext context,
    String clientName,
    String clientId,
    WidgetRef ref,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return FormUploadDialog(
          clientName: clientName,
          dropdownFormSearchFieldController: dropdownFormSearchFieldController,
          getFormSuggestions: getFormSuggestions,
          onSendPressed: () async {
            final formId = dropdownFormSearchFieldController.text;
            if (formId.isNotEmpty) {
              await ref
                  .read(clientListDieticianProvider.notifier)
                  .assignFormToClient(clientId, formId, context, ref);

              // Sadece geri yığın varsa dialogu kapat
              if (Navigator.canPop(dialogContext)) {
                Navigator.of(dialogContext).pop();
              }
            } else {
              showCustomSnackBar(
                context: dialogContext,
                message: ErrorConstants.searchDieticianFormAlert,
              );
            }
          },
        );
      },
    ).then((_) {
      dropdownFormSearchFieldController.clear();
    });
  }

  SizedBox clientCard(BuildContext context, WidgetRef ref) {
    final clientListState = ref.watch(clientListDieticianProvider);
    final clientsToShow = clientListState.searchingClients
        ? clientListState.filteredClients ?? []
        : clientListState.clients;

    return SizedBox(
      width: kIsWeb
          ? Responsiveness.clientCardWeb.w
          : Responsiveness.clientCardMobile.w,
      child: Padding(
        padding: context.padding.onlyTopMedium,
        child: ExpansionTileList(
          tileGapSize: 10,
          children: clientsToShow.map<ExpansionTile>((client) {
            return ExpansionTile(
              title: clientListState.isFetchingClient
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(TColor.white),
                      ),
                    )
                  : SubtitleText(
                      text: client.clientId ?? ' ',
                    ),
              subtitle: clientListState.isFetchingClient
                  ? const SizedBox.shrink()
                  : CardText(
                      text: '${client.clientName} ${client.clientSurname}',
                    ),
              backgroundColor: TColor.airforce,
              collapsedBackgroundColor: TColor.airforce,
              iconColor: TColor.white,
              collapsedIconColor: TColor.white,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            buildOptionCard(
                              context,
                              label: StringConstants.searchDieticianAddDiet,
                              onTap: () => context.route.navigateName(
                                RouteConstant.createDietDietician,
                                data: client.clientId,
                              ),
                            ),
                            buildOptionCard(
                              context,
                              label: StringConstants.searchDieticianUpdateDiet,
                              onTap: () => context.route.navigateName(
                                RouteConstant.editDietDietician,
                                data: client.clientId,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            buildOptionCard(
                              context,
                              label: StringConstants.searchDieticianUploadForm,
                              onTap: () => showFormUploadDialog(
                                context,
                                '${client.clientName} ${client.clientSurname}',
                                client.clientId!,
                                ref,
                              ),
                            ),
                            buildOptionCard(
                              context,
                              label: StringConstants.searchDieticianFormAnswers,
                              onTap: () => context.route.navigateName(
                                RouteConstant.answersFormDietician,
                                data: client.clientId,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDeleteDialog(
                                  context,
                                  ref,
                                  client.clientId!,
                                  client.clientName!,
                                  client.clientSurname!,
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: TColor.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 65),
      child: SafeArea(
        child: CustomSearchBar(
          backIcon: Icons.add_circle,
          backIconColor: TColor.airforce,
          title: StringConstants.searchDieticianSearchAppbarTitle,
          onSearchChanged: (text) {
            ref.read(clientListDieticianProvider.notifier).filterClients(text);
          },
          onSearchCancelled: () {
            ref.read(clientListDieticianProvider.notifier).filterClients('');
          },
          searchTextController: searchController,
          padding: context.padding.horizontalNormal,
          onBackIconPressed: () => showAddClientDialog(context),
        ),
      ),
    );
  }
}
