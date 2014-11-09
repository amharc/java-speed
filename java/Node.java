/* Pairing heap node */
import java.util.*;

public class Node<T extends Comparable> {
  Node<T> son;
  Node<T> sibling;
  T key;

  public Node(T key) {
    this.key = key;
  }

  public Node(T key, Node<T> son, Node<T> sibling) {
    this.key = key;
    this.son = son;
    this.sibling = sibling;
  }

  public Node<T> getSon() {
    return son;
  }

  public Node<T> getSibling() {
    return sibling;
  }

  public T getKey() {
    return key;
  }

  public Node<T> linkTo(Node<T> rhs) {
    if(rhs == null) {
      sibling = null;
      return this;
    }
    else {
      if(key.compareTo(rhs.key) > 0) {
        return rhs.linkTo(this);
      }

      rhs.sibling = son;
      son = rhs;
      sibling = null;

      return this;
    }
  }

  public Node<T> mergedSons() {
    Node<T> cur = son;

    if(cur == null)
      return null;
    else {
      Stack<Node<T>> nodes = new Stack<Node<T>>();

      while(cur != null && cur.sibling != null) {
        Node<T> next = cur.sibling.sibling;
        nodes.push(cur.linkTo(cur.sibling));
        cur = next;
      }

      if(cur != null)
        nodes.add(cur);

      while(nodes.size() > 1) {
        Node n1 = nodes.pop();
        Node n2 = nodes.pop();

        nodes.push(n2.linkTo(n1));
      }

      return nodes.pop();
    }
  }
}
