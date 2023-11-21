// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_translator/view/text_translate/view/text_translate_view.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../global/helper/alerts/are_you_sure_to_delete_alert.dart';
import '../../../../global/helper/copy_text_helper.dart';
import '../../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../../../../global/helper/hive/hive_adapters/history_positioned_widget_adapter.dart';
import '../../../../global/helper/text_sharer.dart';
import '../../../camera_translate/view/camera_translate_view.dart';
import '../../view_model/history_view_model.dart';
import 'history_card/view_model/history_card_view_model.dart';

class HistoryCard extends StatelessWidget {
  HistoryCard({
    super.key,
    required this.item,
    required this.historyVm,
  });

  late BuildContext context;
  HistoryViewModel historyVm;
  HistoryCardViewModel historyCardVm = HistoryCardViewModel();

  HistoryModel item;
  late String title;
  late String subtitle;

  String allTextAsBlock = '';

  void init(BuildContext context) {
    this.context = context;
    if (item.translateToText == null) {
      List positionedBlockWidgets = item.positionedBlockWidgets;
      title = positionedBlockWidgets.first.text;
      for (var element in positionedBlockWidgets) {
        allTextAsBlock += ' ${(element as HistoryPositionedWidgetModel).text}';
      }
      if (positionedBlockWidgets.length == 1) {
        subtitle = positionedBlockWidgets.first.text.replaceAll('\n', ' ');
      } else {
        subtitle =
            (positionedBlockWidgets.first.text + positionedBlockWidgets[1].text)
                .replaceAll('\n', ' ');
      }
    } else {
      try {
        title = item.translateToText!.substring(0, 9);
      } catch (e) {
        int itemLenght = (item.translateToText!.length - 3);
        title = item.translateToText!
            .substring(0, itemLenght <= 0 ? 1 : itemLenght);
      }
      allTextAsBlock = item.translateFromText!;
      subtitle = item.translateToText!;
    }
    historyCardVm.setHistoryModel(item);
    historyCardVm.setThisHistoryCardViewModel(historyCardVm);
    historyCardVm.init(allTextAsBlock);
    historyCardVm.setContext(context);
  }

  void pushToOtherPage() {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => item.translateToText == null
            ? CameraTranslateView(historyModel: item, openBackButton: true)
            : TextTranslateView(historyModel: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Card(
      color: const Color(0xff343034),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: pushToOtherPage,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: context.height * 0.02,
              horizontal: context.width * 0.04,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildImageWidget(),
                      Observer(builder: (context) {
                        return buildIconButton(
                          icon: historyCardVm.isTtsPlaying
                              ? CupertinoIcons.stop_circle
                              : CupertinoIcons.play_circle,
                          color: historyCardVm.isTtsPlaying
                              ? Colors.orange
                              : Colors.greenAccent,
                          onTap: () => historyCardVm.isTtsPlaying
                              ? historyCardVm.stopRead()
                              : historyCardVm.readText(),
                        );
                      }),
                    ],
                  ),
                  SizedBox(width: context.width * 0.04),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitlteWidget(),
                        buildSubtitleWidget(),
                        SizedBox(height: context.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildIconButton(
                                  icon: CupertinoIcons.doc_on_doc,
                                  color: Colors.blueAccent,
                                  onTap: allTextAsBlock.isEmpty
                                      ? null
                                      : () {
                                          copyText(allTextAsBlock);
                                          historyCardVm.stopRead();
                                        },
                                ),
                                SizedBox(width: context.width * 0.07),
                                buildIconButton(
                                  icon: CupertinoIcons.share,
                                  color: Colors.orangeAccent,
                                  onTap: allTextAsBlock.isEmpty
                                      ? null
                                      : () {
                                          share(allTextAsBlock);
                                          historyCardVm.stopRead();
                                        },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${item.fromLanguageModel.code!} - ${item.toLanguageModel.code!}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                buildIconButton(
                                  icon: CupertinoIcons.delete_simple,
                                  color: Colors.redAccent,
                                  onTap: () => showBasicAlertDialog(
                                    context,
                                    onPositiveButtonPressed: () {
                                      historyVm.deleteHistory(item);
                                      historyCardVm.stopRead();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: context.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconButton({
    required IconData icon,
    required Function()? onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: color ?? Colors.grey.shade500,
        size: context.width * 0.06,
      ),
    );
  }

  Widget buildTitlteWidget() {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: context.width * 0.043,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildSubtitleWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        subtitle,
        style: TextStyle(
            color: Colors.white,
            fontSize: context.width * 0.035,
            fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildImageWidget() {
    return item.imagePath == null
        ? buildTextImage()
        : Container(
            width: context.width * 0.12,
            height: context.width * 0.12,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.circular(9999),
              image: DecorationImage(
                image: FileImage(File(item.imagePath!)),
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget buildTextImage() {
    return Icon(
      Icons.text_fields_rounded,
      size: context.width * 0.12,
      color: Colors.white,
    );
  }
}
