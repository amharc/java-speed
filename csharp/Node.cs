/* Pairing heap node */

using System;
using System.Collections.Generic;

public class Node<T> where T : IComparable {
  public Node<T> Son { get; private set; }
  public Node<T> Sibling { get; private set; }
  public T Key { get; private set; }

  public Node(T key) {
    this.Key = key;
  }

  public Node<T> LinkTo( Node<T> rhs) {
    if(rhs == null) {
      Sibling = null;
      return this;
    }
    else {
      if(Key.CompareTo(rhs.Key) > 0) {
        return rhs.LinkTo(this);
      }

      rhs.Sibling = Son;
      Son = rhs;
      Sibling = null;

      return this;
    }
  }

  public Node<T> MergedSons() {
    Node<T> cur = Son;

    if(cur == null)
      return null;
    else {
      Stack<Node<T>> nodes = new Stack<Node<T>>();

      while(cur != null && cur.Sibling != null) {
        Node<T> next = cur.Sibling.Sibling;
        nodes.Push(cur.LinkTo(cur.Sibling));
        cur = next;
      }

      if(cur != null)
        nodes.Push(cur);

      while(nodes.Count > 1) {
        Node<T> n1 = nodes.Pop();
        Node<T> n2 = nodes.Pop();

        nodes.Push(n2.LinkTo(n1));
      }

      return nodes.Pop();
    }
  }
}
