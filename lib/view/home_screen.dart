import 'package:detect_tap_across_widgets_sample/main.dart';
import 'package:detect_tap_across_widgets_sample/view/tap_detect_across_widgets/hit_test_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
* Widgetをまたぐタップイベントを検知する方法
* https://programmer-record.com/flutter-gesture-longtap-detector/#toc4
* => ちょっとこれはいまいちなので、おそらくこの記事を書いた人が参照したと思われるRemiさんの回答に沿って実装
*   https://stackoverflow.com/a/52625182/7300575
* */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //選択されたセルの配列番号を格納するためのSet
  final _selectedIndexes = Set<int>();
  final _gridViewKey = GlobalKey();
  final _trackTapped = Set<HitTestDetectorRenderBox>();

  final texts = ["あ", "い", "う", "え", "お", "へ", "と", "ち", "り", "ぬ", "す", "と"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: _clearSelection,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //https://api.flutter.dev/flutter/widgets/Listener-class.html
        child: Listener(
          onPointerDown: _detectTappedItem,
          onPointerMove: _detectTappedItem,
          //onPointerUp: _clearSelection,
          child: GridView.builder(
            key: _gridViewKey,
            itemCount: texts.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              return HitTestDetector(
                index: index,
                child: Container(
                  child: Center(
                    child: Text(texts[index]),
                  ),
                  color: _selectedIndexes.contains(index)
                      ? Colors.redAccent
                      : Colors.blueAccent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _detectTappedItem(PointerEvent event) {
    //print("_detectTappedItem");
    final renderObject = _gridViewKey.currentContext?.findRenderObject();
    if (renderObject == null) return;
    final renderBox = renderObject as RenderBox;
    final hitTestResult = BoxHitTestResult();
    final localEventPosition = renderBox.globalToLocal(event.position);
    if (renderBox.hitTest(hitTestResult, position: localEventPosition)) {
      for (final hit in hitTestResult.path) {
        final hitTestTarget = hit.target;
        if (hitTestTarget is HitTestDetectorRenderBox && !_trackTapped.contains(hitTestTarget)) {
          _trackTapped.add(hitTestTarget);
          final targetIndex = hitTestTarget.index;
          _speak(targetIndex);
          setState(() {
            print("hitTestTarget.index: ${targetIndex}");
            _selectedIndexes.add(targetIndex);
          });
        }
      }
    }
  }

  void _clearSelection() {
  //void _clearSelection(PointerEvent event) {
    _trackTapped.clear();
    setState(() {
      _selectedIndexes.clear();
    });
  }

  _speak(int index) {
    print("__speak");
    ttsManager.speak(texts[index]);
  }
}
