/* Pairing heap */
public class Heap<T extends Comparable> {
  Node<T> root;

  public T top() {
    return root.getKey();
  }

  public void pop() {
    root = root.mergedSons();
  }

  public void insert(T key) {
    Node<T> singleton = new Node<T>(key);
    root = singleton.linkTo(root);
  }

  public boolean isEmpty() {
    return root == null;
  }
}
