import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'edit_diet_dietician_mixin.dart';

mixin EditDietDieticianUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, EditDietDieticianMixin<T> {
  // Ortak AppBar
  CommonAppbar appBar(BuildContext context) {
    return const CommonAppbar(
      title: StringConstants.editDietDieticianTitle,
    );
  }

  Widget chooseDayDropdown(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: DropdownButtonChooseDay(
        width: kIsWeb
            ? Responsiveness.editDietChooseDayDropdownWeb
            : Responsiveness.editDietChooseDayDropdownMobile,
        items: StringConstants.daysOfWeek,
        selectedDay: selectedDay,
        onChanged: (selected) {
          setState(() {
            selectedDay = selected!; // Günü seçiyoruz
            // Eğer seçilen gün için öğün verisi varsa onları göster, yoksa yeni başlat
            if (!mealsByDay.containsKey(selectedDay)) {
              mealsByDay[selectedDay] = [];
            }

            mealsByDay[selectedDay] =
                mealsByDay[selectedDay]!; // Günün öğün listesini yükle
          });
        },
      ),
    );
  }

// Öğün ekleme butonu
  Widget addMealButtonwithChooseDay() {
    return Column(
      children: [
        chooseDayDropdown(context), // Gün seçimi dropdown'u
        if (selectedDay != 'Gün Seçiniz')
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: TColor.airforce,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: addMeal, // Yeni öğün ekleme
            icon: Icon(
              Icons.add,
              color: TColor.black,
            ),
            label: kIsWeb
                ? const WebText(
                    text: StringConstants.createDietDieticianAddMeal)
                : const BoldText(
                    text: StringConstants.createDietDieticianAddMeal),
          ),
      ],
    );
  }

  Widget buildMealCard(int mealIndex) {
    final mealController = mealControllersByDay[selectedDay]![mealIndex];
    final mealName = mealsByDay[selectedDay]![mealIndex];

    return SizedBox(
      width: kIsWeb
          ? Responsiveness.editDietMealCardWeb.w
          : Responsiveness.editDietMealCardMobile.w,
      child: Card(
        color: TColor.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: TColor.airforce, width: 2),
        ),
        elevation: 10,
        shadowColor: TColor.airforce.withOpacity(0.5),
        child: Padding(
          padding: context.padding.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Öğün adı
              SizedBox(
                width: kIsWeb
                    ? Responsiveness.editDietContentNameWeb.w
                    : Responsiveness.editDietContentNameMobile.w,
                child: CreateDietMealNameTextField(
                  labelText: StringConstants.createDietDieticianMealName,
                  controller: mealController, // Öğün adını düzenler
                  onChanged: (value) {
                    setState(() {
                      // Nokta ve virgül karakterlerini iki nokta ile değiştirme
                      final updatedValue =
                          value.replaceAll(RegExp('[.,]'), ':');
                      mealsByDay[selectedDay]![mealIndex] = updatedValue;

                      // Eğer mevcut bir öğün varsa güncellenir, yoksa yeni eklenir
                      if (mealDetailsByDay[selectedDay]!
                          .containsKey(mealName)) {
                        mealDetailsByDay[selectedDay]![updatedValue] =
                            mealDetailsByDay[selectedDay]!.remove(mealName) ??
                                [];
                        contentControllersByDay[selectedDay]![updatedValue] =
                            contentControllersByDay[selectedDay]!
                                    .remove(mealName) ??
                                [];
                        numberControllersByDay[selectedDay]![updatedValue] =
                            numberControllersByDay[selectedDay]!
                                    .remove(mealName) ??
                                [];
                        mealContentControllersByDay[selectedDay]![
                                updatedValue] =
                            mealContentControllersByDay[selectedDay]!
                                    .remove(mealName) ??
                                [];
                        dropdownValueUnitControllersByDay[selectedDay]![
                                updatedValue] =
                            dropdownValueUnitControllersByDay[selectedDay]!
                                    .remove(mealName) ??
                                [];
                      } else {
                        mealDetailsByDay[selectedDay]![updatedValue] = [];
                        contentControllersByDay[selectedDay]![updatedValue] =
                            [];
                        numberControllersByDay[selectedDay]![updatedValue] = [];
                        mealContentControllersByDay[selectedDay]![
                            updatedValue] = [];
                        dropdownValueUnitControllersByDay[selectedDay]![
                            updatedValue] = [];
                      }
                    });
                  },
                ),
              ),
              // İçerik listesi
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    mealDetailsByDay[selectedDay]?[mealName]?.length ?? 0,
                itemBuilder: (context, contentIndex) {
                  return buildMealContentField(mealIndex, contentIndex);
                },
              ),
              context.sized.emptySizedHeightBoxLow3x,
              buildAddMealContentButton(mealIndex), // İçerik ekleme butonu
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    removeMeal(mealIndex); // Öğün silme
                  },
                  icon: Icon(Icons.delete, color: TColor.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// İçerik formu (Her öğünün içerikleri için input alanları)
  Widget buildMealContentField(int mealIndex, int contentIndex) {
    final mealName = mealsByDay[selectedDay]![mealIndex];

    // Miktar ve besin controller'larını mixin'den alıyoruz
    final numberController =
        numberControllersByDay[selectedDay]![mealName]![contentIndex];
    final mealController =
        mealContentControllersByDay[selectedDay]![mealName]![contentIndex];

    // dropdownValueUnit için güvenli kontrol ekliyoruz
    final dropdownValueUnit = dropdownValueUnitControllersByDay[selectedDay]![
        mealName]![contentIndex];

    // Verileri her input değişiminde birleştirip kaydetme fonksiyonu
    void updateMealDetails() {
      setState(() {
        final mealContent =
            '/${numberController.text}/${dropdownValueUnitControllersByDay[selectedDay]![mealName]![contentIndex]}/${mealController.text}';
        mealDetailsByDay[selectedDay]![mealName]![contentIndex] = mealContent;
      });
    }

    return Column(
      children: [
        context.sized.emptySizedHeightBoxLow3x,
        Row(
          children: [
            // Eski RoundTextFormField yerine yeni CreateDietRow widget'ı kullanılıyor
            CreateDietRow(
              textNumberController: numberController, // Miktar controller
              dropdownValueUnit: dropdownValueUnit, // Varsayılan birim
              textMealController: mealController, // Besin controller
              onChangedDropdownUnit: (newValue) {
                dropdownValueUnitControllersByDay[selectedDay]![mealName]![
                    contentIndex] = newValue ?? 'empty'; // Seçili birimi kaydet
              },
              onChanged: (value) {
                updateMealDetails();
              },
            ),

            kIsWeb
                ? context.sized.emptySizedWidthBoxLow
                : const SizedBox.shrink(),

            IconButton(
              onPressed: () {
                removeMealContent(mealIndex, contentIndex);
              },
              icon: Icon(Icons.delete, color: TColor.black),
            ),
          ],
        ),
      ],
    );
  }

  // İçerik ekleme butonu
  Widget buildAddMealContentButton(int mealIndex) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: TColor.airforce,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        addMealContent(mealIndex); // Yeni içerik ekleme
      },
      icon: Icon(
        Icons.add,
        color: TColor.black,
      ),
      label: kIsWeb
          ? const WebText(text: StringConstants.createDietDieticianEnterContent)
          : const BoldText(
              text: StringConstants.createDietDieticianEnterContent),
    );
  }

  // Diyeti gönder butonu
  Widget updateDietButton() {
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
      child: SizedBox(
        width: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: TColor.airforce,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            await sendDiet(ref); // Diyeti gönder
          },
          child: kIsWeb
              ? const WebText(text: StringConstants.createDietDieticianSendDiet)
              : const BoldText(
                  text: StringConstants.createDietDieticianSendDiet),
        ),
      ),
    );
  }

  // Öğün listesi (Tüm öğünleri gösterir)
  Widget mealList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: kIsWeb
                ? Responsiveness.editDietCardWeb.w
                : Responsiveness.editDietCardMobile.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mealsByDay[selectedDay]?.length ?? 0,
                  itemBuilder: (context, index) {
                    return buildMealCard(index); // Öğün kartı
                  },
                ),
                context.sized.emptySizedHeightBoxLow,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
