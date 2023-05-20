import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

extension ContextScrollExtension on BuildContext{
  ///从子RenderObject 向上找T类型的RenderObject,maxCycleCount向上查找的深度
  T? findAncestorRenderObj<T extends RenderObject>({int maxCycleCount = 10}) {
    final obj = findRenderObject();
    if (obj == null) return null;
    int currentCycleCount = 1;
    AbstractNode? parent = obj.parent;
    while (parent != null && currentCycleCount <= maxCycleCount) {
      if (parent is T) {
        return parent;
      }
      parent = parent.parent;
      currentCycleCount++;
    }
    return null;
  }

  ///从子RenderObject 向上找ViewPort,maxCycleCount向上查找的深度
  ///SingleChildScroll的 viewport是_RenderSingleChildViewport类型
  RenderViewportBase? findViewport({int maxCycleCount = 10}) {
    return findAncestorRenderObj<RenderViewportBase>(
        maxCycleCount: maxCycleCount);
  }

  ///从子RenderObject 向上找ViewPort,一直遍历到根节点
  RenderAbstractViewport? findViewportToRoot() {
    return RenderAbstractViewport.maybeOf(findRenderObject());
  }

  ///是否位于ScrollView中
  bool isInScrollView(RenderAbstractViewport? viewport) {
    return viewport != null;
  }
}