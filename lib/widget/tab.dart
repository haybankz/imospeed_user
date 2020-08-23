import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';

class TabWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;
  final bool scrollableTab;
  TabWidget({@required this.tabs, @required this.views, this.scrollableTab = false});
  @override
  State createState() => _TabState();
}

class _TabState extends State<TabWidget> with SingleTickerProviderStateMixin {
//  final List<String> tabs;
//  final List<Widget> views;

//  _TabState({this.tabs, this.views});

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenWidth(context),
            decoration: BoxDecoration(
                color: Constants.lightPrimary,
                border:
                Border(bottom: BorderSide(color: Colors.grey, width: 0.8))),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Constants.lightAccent,
              isScrollable: widget.scrollableTab,
              labelPadding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              indicatorPadding: EdgeInsets.only(left: 0, right: 0),
              indicatorSize: TabBarIndicatorSize.tab,
//              tabs: tabList
              tabs: widget.tabs
                  .map((tabTitle) => SizedBox(
                key: new PageStorageKey(tabTitle),
                height: 36,
                child: Tab(
                  child: Text(
                    '$tabTitle',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 13),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
//        YMargin(4),
          Expanded(
            child: Container(
              color: Constants.offWhite,
              width: screenWidth(context,),
              child: TabBarView(
                controller: _tabController,
                children: widget.views,
              ),
            ),
          )
        ],
      ),
    );
  }




}
