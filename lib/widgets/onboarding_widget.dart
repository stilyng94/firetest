import 'dart:io';
import 'package:firetest/core/constants/asset_paths.dart';
import 'package:firetest/core/shared/size_config.dart';
import 'package:firetest/generated/l10n.dart';
import 'package:firetest/routes/router.dart';
import 'package:firetest/services/general_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:firetest/core/responsive_body_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatefulWidget {
  static final onBoardData = [
    OnBoardModel(Colors.red, "First Screen", AssetPaths.SPLASH_SVG),
    OnBoardModel(Colors.yellow, "Second screen", AssetPaths.SPLASH_SVG),
    OnBoardModel(Colors.green, "Third screen", AssetPaths.SPLASH_SVG)
  ];
  static const spacer = 20.0;

  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
  }

  void onChangedFunction(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void onBtnClickedHandler() async {
    if (pageIndex < 2) {
      await pageController.nextPage(
          duration: Duration(milliseconds: 1), curve: Curves.ease);
    } else {
      await Get.offAllNamed(Routes.AUTH_ROUTE);
    }
    return;
  }

  Future<void> onLang() async {
    await Get.find<GeneralService>().updateLanguage("sw");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BuildResponsiveChild(
      child: Stack(
        children: [
          PageView.builder(
              itemBuilder: (context, index) => OnBoardBody(
                  onBoardModel: OnBoardingWidget.onBoardData[index]),
              itemCount: OnBoardingWidget.onBoardData.length,
              controller: pageController,
              onPageChanged: onChangedFunction),
          ElevatedButton(
            child: Text("Translate"),
            onPressed: onLang,
          ),
          Positioned(
              height: 55,
              bottom: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OnBoardRowBuilder(
                      onBoardData: OnBoardingWidget.onBoardData,
                      pageIndex: pageIndex,
                    ),
                    OnBoardBtn(
                      index: pageIndex,
                      onBoardModel: OnBoardingWidget.onBoardData[pageIndex],
                      callback: onBtnClickedHandler,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class OnBoardBody extends StatelessWidget {
  final int index;
  final OnBoardModel onBoardModel;

  const OnBoardBody({Key key, this.index, this.onBoardModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: getProportionateScreenWidth(200.0),
            width: getProportionateScreenWidth(200.0),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              onBoardModel.assetPath,
              semanticsLabel: "Farmer loading",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          Text(onBoardModel.message)
        ]);
  }
}

class OnBoardBtn extends StatelessWidget {
  final int index;
  final VoidCallback callback;
  final OnBoardModel onBoardModel;

  const OnBoardBtn(
      {Key key,
      @required this.index,
      @required this.callback,
      @required this.onBoardModel})
      : super(key: key);

  Row buildChild(String btnText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              btnText,
            )),
        SizedBox(
          width: getProportionateScreenWidth(16.0),
        ),
        Icon(Platform.isIOS
            ? CupertinoIcons.forward
            : Icons.arrow_forward_ios_outlined)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String msg = index < 2 ? LangTranslator.of(context).greeting : "Get Started";
    return Platform.isIOS
        ? CupertinoButton(
            color: onBoardModel.color,
            child: buildChild(msg),
            onPressed: callback,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          )
        : ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(onBoardModel.color)),
            onPressed: callback,
            child: buildChild(msg),
          );
  }
}

class OnBoardIndicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  final Color color;

  const OnBoardIndicator(
      {Key key,
      @required this.positionIndex,
      @required this.currentIndex,
      this.color = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade50),
          color: positionIndex == currentIndex ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}

class OnBoardRowBuilder extends StatelessWidget {
  final List<OnBoardModel> onBoardData;
  final int pageIndex;
  const OnBoardRowBuilder(
      {Key key, @required this.onBoardData, @required this.pageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.0,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: onBoardData.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => OnBoardIndicator(
                positionIndex: index,
                currentIndex: pageIndex,
                color: onBoardData[index].color,
              )),
    );
  }
}

class OnBoardModel {
  Color color;
  String message;
  String assetPath;

  OnBoardModel(this.color, this.message, this.assetPath);
}
