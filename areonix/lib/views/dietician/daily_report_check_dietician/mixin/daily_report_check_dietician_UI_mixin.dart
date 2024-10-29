import 'package:areonix/core/constants/color/color_constants.dart';
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
import '../provider/daily_report_check_dietician_provider.dart';
import 'daily_report_check_dietician_mixin.dart';

mixin DailyReportCheckDieticianUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, DailyReportCheckDieticianMixin<T> {
  // ExpansionTileList, tüm client'ları listeler
  SizedBox clientCard(BuildContext context, WidgetRef ref) {
    final clientListState = ref.watch(dailyReportCheckDieticianProvider);
    final clientsToShow = clientListState.searchingClients
        ? clientListState.filteredClients ?? []
        : clientListState.clients;

    return SizedBox(
      width: kIsWeb
          ? Responsiveness.dailyreportcheckCardWeb.w
          : Responsiveness.dailyreportcheckCardMobile.w,
      child: Padding(
        padding: context.padding.onlyTopMedium,
        child: ExpansionTileList(
          tileGapSize: 10,
          children: clientsToShow.map<ExpansionTile>((client) {
            return ExpansionTile(
              title: SubtitleText(
                text: client.clientId ?? ' ',
              ),
              subtitle: CardText(
                text: '${client.clientName} ${client.clientSurname}',
              ),
              backgroundColor: TColor.airforce,
              collapsedBackgroundColor: TColor.airforce,
              iconColor: TColor.white,
              collapsedIconColor: TColor.white,
              children:
                  _buildDateTilesForClient(context, ref, client.clientId!),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _buildDateTilesForClient(
    BuildContext context,
    WidgetRef ref,
    String clientId,
  ) {
    // Dosya bilgilerini provider'dan alıyoruz
    final allFiles = ref.watch(dailyReportCheckDieticianProvider).allFiles;

    // Eğer veri yükleniyorsa, CircularProgressIndicator göster
    if (allFiles == null) {
      return [
        Center(
          child: CircularProgressIndicator(
            color: TColor.white,
            strokeWidth: 2,
          ),
        ),
      ];
    }

    // Eğer veri boşsa, bilgi mesajı göster
    if (allFiles.isEmpty) {
      return [
        const Center(
          child: BoldText(
            text: ErrorConstants.dailyReportCheckNoReport,
          ),
        ),
      ];
    }

    // Client ID'ye göre dosya verilerini filtreliyoruz
    final clientFiles =
        allFiles.where((file) => file['clientId'] == clientId).toList();

    // Eğer client dosya yüklemediyse, bilgi mesajı göster
    if (clientFiles.isEmpty) {
      return [
        const ListTile(
          title: Center(
            child: BoldText(
              text: ErrorConstants.dailyReportCheckNoReport,
            ),
          ),
        ),
      ];
    }

    // Tarihe göre gruplama
    final groupedFilesByDate = <String, List<Map<String, dynamic>>>{};
    for (final file in clientFiles) {
      final date = file['date'] ?? ErrorConstants.dailyReportMealUnknown;
      if (!groupedFilesByDate.containsKey(date)) {
        groupedFilesByDate[date] = [];
      }
      groupedFilesByDate[date]!.add(file);
    }

    // Gruplanmış verileri göster
    return groupedFilesByDate.entries.map<Widget>((entry) {
      final date = entry.key;
      final filesForDate = entry.value;

      // Assuming dietLength is available in each file's data
      final dietLength = filesForDate.isNotEmpty
          ? filesForDate.first['dietLength']
          : ErrorConstants.dailyReportMealUnknown;

      return SizedBox(
        width: kIsWeb
            ? Responsiveness.dailyreportcheckDetailCardWeb.w
            : Responsiveness.dailyreportcheckDetailCardMobile.w,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: InkWell(
            onTap: () {
              context.route.navigateName(
                RouteConstant.dailyReportDetailsDietician,
                data: filesForDate,
              );
            },
            child: Padding(
              padding: context.padding.normal,
              child: Row(
                children: [
                  Column(
                    children: [
                      BoldText(
                        text: '${StringConstants.dailyReportCheckDate} $date',
                      ),
                      const SizedBox(height: 10),
                      NormalText(
                        text:
                            '${StringConstants.dailyReportMealCount} $dietLength/${filesForDate.length}',
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      context.route.navigateName(
                        RouteConstant.dailyReportDetailsDietician,
                        data: filesForDate,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.airforce,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 65),
      child: SafeArea(
        child: CustomSearchBar(
          title: StringConstants.dailyReportCheckDieticianTitle,
          onSearchChanged: (text) {
            ref
                .read(dailyReportCheckDieticianProvider.notifier)
                .filterClients(text);
          },
          onSearchCancelled: () {
            ref
                .read(dailyReportCheckDieticianProvider.notifier)
                .filterClients('');
          },
          searchTextController: searchController,
          padding: context.padding.horizontalNormal,
          onBackIconPressed: () {},
        ),
      ),
    );
  }
}
