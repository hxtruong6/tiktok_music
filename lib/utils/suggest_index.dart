import 'dart:math';

class SuggestIndex {
  int prevIdx = 0;
  int idx = 0;
  int n;

  SuggestIndex(int n, int index) {
    n = n;
    idx = index;
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
