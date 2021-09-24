import 'package:cafe_joveth_tecnologia/util/keys.dart';
import 'package:cafe_joveth_tecnologia/util/sizing_info.dart';
import 'package:cafe_joveth_tecnologia/values/responsive_app.dart';
import 'package:cafe_joveth_tecnologia/widgets/components/carousel.dart';
import 'package:cafe_joveth_tecnologia/widgets/web_components/body/menu_section.dart';
import 'package:cafe_joveth_tecnologia/widgets/web_components/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _scrollPosition = 0;
  double _opacity = 0;

  late AutoScrollController autoScrollController;
  bool _isVisible = false;
  late ResponsiveApp responsiveApp;

  _scrollListener() {
    setState(() {
      _scrollPosition = autoScrollController.position.pixels;
    });
  }

  @override
  void initState() {
    autoScrollController = AutoScrollController(
        //add this for advanced viewport boundary. e.g. SafeArea
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    autoScrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);

    _opacity = _scrollPosition < responsiveApp.opacityHeight
        ? _scrollPosition / responsiveApp.opacityHeight
        : 1;

    _isVisible = _scrollPosition >= responsiveApp.menuHeight;
    return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: Visibility(
          visible: _isVisible,
          child: FloatingActionButton(
            onPressed: () => {autoScrollController.scrollToIndex(0)},
            child: Icon(Icons.arrow_upward),
          ),
        ),
        appBar: Header(_opacity),
        /* isMobileAndTablet(context)
            ? ShopAppBar(_opacity)
            : Header(_opacity),
        drawer: ShopDrawer(),*/
        body: ListView(controller: autoScrollController, children: [
          Carousel(),
          MenuSection(autoScrollController)
          /* isMobileAndTablet(context)
              ? MenuTap()
              : SectionListView(autoScrollController),
          isMobileAndTablet(context) ? SizedBox.shrink() : Footer()*/
        ]));
  }
}
