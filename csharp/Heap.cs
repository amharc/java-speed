/* Pairing heap */

using System;

public class Heap<T> where T : IComparable {
  Node<T> Root;

  public T Top() {
    return Root.Key;
  }

  public void Pop() {
    Root = Root.MergedSons();
  }

  public void Insert(T key) {
    Node<T> singleton = new Node<T>(key);
    Root = singleton.LinkTo(Root);
  }

  public bool IsEmpty() {
    return Root == null;
  }
}
