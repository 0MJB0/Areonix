import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

typedef SearchCallback = void Function(String);
typedef SearchCancelledCallback = VoidCallback;

final isSearchingProvider = StateProvider.autoDispose((ref) => false);

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    Key? key,
    this.searchBarWidth,
    this.searchBarHeight,
    this.backIconColor,
    this.closeIconColor,
    this.searchIconColor,
    this.title,
    this.titleStyle,
    this.searchFieldHeight,
    this.searchFieldDecoration,
    this.cursorColor,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    required this.onSearchChanged,
    required this.searchTextController,
    this.padding,
    this.isBackButtonVisible,
    this.backIcon,
    this.animationDuration,
    required this.onBackIconPressed,
    this.onSearchCancelled, // Yeni eklendi
  }) : super(key: key);

  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? searchFieldHeight;
  final EdgeInsets? padding;
  final Color? backIconColor;
  final Color? closeIconColor;
  final Color? searchIconColor;
  final Color? cursorColor;
  final String? title;
  final String? hintText;
  final bool? isBackButtonVisible;
  final IconData? backIcon;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Decoration? searchFieldDecoration;
  final Duration? animationDuration;
  final TextEditingController searchTextController;
  final SearchCallback onSearchChanged;
  final VoidCallback onBackIconPressed;
  final SearchCancelledCallback? onSearchCancelled;

  @override
  Widget build(BuildContext context) {
    final _duration = animationDuration ?? const Duration(milliseconds: 500);
    final _searchFieldHeight = searchFieldHeight ?? 40;
    final _searchBarWidth = searchBarWidth ?? MediaQuery.of(context).size.width;
    final _isBackButtonVisible = isBackButtonVisible ?? true;

    return ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        final isSearching = ref.watch(isSearchingProvider);
        final searchNotifier = ref.read(isSearchingProvider.notifier);

        return Container(
          decoration: BoxDecoration(
            color: TColor.white,
            boxShadow: BoxShadowType.medium.boxShadow,
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: SizedBox(
              width: _searchBarWidth,
              height: searchBarHeight ?? 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_isBackButtonVisible)
                    AnimatedOpacity(
                      opacity: isSearching ? 0 : 1,
                      duration: _duration,
                      child: AnimatedContainer(
                        duration: _duration,
                        width: isSearching ? 0 : 25,
                        height: 25,
                        child: FittedBox(
                          child: InkWell(
                            onTap: onBackIconPressed,
                            child: Icon(
                              backIcon,
                              color: backIconColor ?? Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  AnimatedOpacity(
                    opacity: isSearching ? 0 : 1,
                    duration: _duration,
                    child: AnimatedContainer(
                      duration: _duration,
                      width: isSearching ? 0 : _searchBarWidth - 100,
                      alignment: Alignment.center,
                      child: kIsWeb
                          ? WebAppbarText(
                              text: title ?? ' ',
                            )
                          : AppbarText(
                              text: title ?? ' ',
                            ),
                    ),
                  ),
                  if (isSearching)
                    AnimatedOpacity(
                      opacity: 1,
                      duration: _duration,
                      child: AnimatedContainer(
                        duration: _duration,
                        width: 35,
                        height: 35,
                        child: InkWell(
                          onTap: () {
                            searchNotifier.state = false;
                            searchTextController.clear();
                            if (onSearchCancelled != null) {
                              onSearchCancelled?.call();
                            }
                          },
                          child: Icon(
                            Icons.close,
                            color: closeIconColor ?? Colors.black,
                          ),
                        ),
                      ),
                    ),
                  AnimatedOpacity(
                    opacity: isSearching ? 1 : 0,
                    duration: _duration,
                    child: AnimatedContainer(
                      duration: _duration,
                      width: isSearching ? _searchBarWidth - 75 : 0,
                      height: _searchFieldHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: searchFieldDecoration ??
                          BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                      child: TextField(
                        controller: searchTextController,
                        cursorColor: cursorColor ?? Colors.black,
                        style: context.general.textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: hintText ?? 'Ara...',
                          hintStyle: context.general.textTheme.bodySmall
                              ?.copyWith(color: TColor.airforce),
                          border: InputBorder.none,
                        ),
                        onChanged: onSearchChanged,
                      ),
                    ),
                  ),
                  if (!isSearching)
                    AnimatedOpacity(
                      opacity: 1,
                      duration: _duration,
                      child: AnimatedContainer(
                        duration: _duration,
                        width: 35,
                        height: 35,
                        child: InkWell(
                          onTap: () {
                            searchNotifier.state = true;
                          },
                          child: Icon(
                            Icons.search,
                            color: searchIconColor ?? Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
