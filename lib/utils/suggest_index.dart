import 'dart:math';

import 'package:flutter/cupertino.dart';

class SuggestIndex {
  int prevIdx = 0;
  int idx = 0;
  int n;

  SuggestIndex(int n, int index) {
    this.n = n;
    this.idx = index;
  }

  setProperites({@required n, index}) {
    this.n = n;
    this.idx = index;
  }

  int index() {
    prevIdx = idx;
    idx = (idx + 1) % n;
    return idx;
  }

  int upGesture() {
    prevIdx = idx;
    idx = (idx * 2) % n;
    return idx;
  }

  int downGesture() {
    prevIdx = idx;
    idx = idx ~/ 2;
    return idx;
  }

  int rightGesture() {
    prevIdx = idx;
    idx = idx + 1 + new Random().nextInt(10) % n;
    return idx;
  }

  int leftGesture() {
    prevIdx = idx;
    idx = idx - 1 + -new Random().nextInt(10) % n;
    return idx;
  }
}
