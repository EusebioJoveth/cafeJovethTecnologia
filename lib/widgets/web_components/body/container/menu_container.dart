import 'package:cafe_joveth_tecnologia/modelo/menu_model.dart';
import 'package:cafe_joveth_tecnologia/values/responsive_app.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({Key? key, required this.index, this.onPress})
      : super(key: key);

  final int index;
  final onPress;

  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  late ResponsiveApp responsiveApp;
  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Padding(
        padding: responsiveApp.edgeInsetsApp.hrzSmallEdgeInsets,
        child: InkWell(
          onTap: () => widget.onPress(),
          child: Container(
              width: responsiveApp.menuContainerWidth,
              height: responsiveApp.menuContainerHeight,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(responsiveApp.menuRadiusWidth))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      menu[widget.index].image,
                      width: responsiveApp.menuImageWidth,
                      height: responsiveApp.menuImageHeight,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      menu[widget.index].title,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ])),
        ));
  }
}