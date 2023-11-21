import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../global/constants/app_colors.dart';
import '../../../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../../../view_model/history_view_model.dart';
import '../history_card.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryViewModel historyVm = HistoryViewModel();

  late Future pageFuture;

  @override
  void initState() {
    pageFuture = historyVm.getAllHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    historyVm.setContext(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text(
          'History',
          style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontSize: context.height * .03,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.darkBackground,
      body: FutureBuilder<void>(
        future: pageFuture,
        builder: (context, snapshot) {
          List<HistoryModel>? data = historyVm.allHistory;
          bool isDone = snapshot.connectionState == ConnectionState.done;
          if (isDone && data != null) {
            if (data.isEmpty) return buildEmptyWidget;
            return Column(
              children: [
                SizedBox(height: context.height * .005),
                searchTextFieldForList(),
                buildHistoryListView(),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }

  Color greyShade400 = Colors.grey.shade400;

  Widget searchTextFieldForList() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * .01,
        horizontal: context.width * .02,
      ),
      child: TextField(
        onChanged: (text) => historyVm.search(text),
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        controller: historyVm.searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(CupertinoIcons.search, color: greyShade400),
          suffixIcon: IconButton(
            onPressed: () => historyVm.clearSearchText(),
            icon: const Icon(
              CupertinoIcons.delete_left,
              color: Colors.redAccent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyShade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyShade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyShade400),
          ),
        ),
      ),
    );
  }

  Widget get buildEmptyWidget => const Center(
        child: Text('Empty', style: TextStyle(color: Colors.white)),
      );

  Widget buildHistoryListView() {
    return Expanded(
      child: Observer(builder: (context) {
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemCount: historyVm.allHistory!.length,
          itemBuilder: (context, index) {
            if (historyVm.allHistory!.isEmpty) {
              return Center(child: Text('boş'));
            }
            var item = historyVm.allHistory![index];
            return HistoryCard(
              item: item,
              historyVm: historyVm,
            );
          },
        );
      }),
    );
  }
}
