#include <stack>
#include <cstdio>

template<class T>
class Node {
  Node<T> *son, *sibling;
  T key;

  public:
  Node(const T& key) : son(nullptr), sibling(nullptr), key(key) { }

  ~Node() {
    if(son)
      delete son;

    if(sibling)
      delete sibling;
  }

  T getKey() const {
    return key;
  }

  Node<T>* linkTo(Node<T> *rhs) {
    if(!rhs) {
      sibling = nullptr;
      return this;
    }
    else {
      if(rhs->key < key)
        return rhs->linkTo(this);

      rhs->sibling = son;
      son = rhs;
      sibling = nullptr;

      return this;
    }
  }

  Node<T>* mergedSons() {
    Node<T> *cur = son;

    if(!cur)
      return nullptr;
    else {
      std::stack<Node<T>*> nodes;

      while(cur && cur->sibling) {
        auto next = cur->sibling->sibling;
        nodes.push(cur->linkTo(cur->sibling));
        cur = next;
      }

      if(cur)
        nodes.push(cur);

      while(nodes.size() > 1) {
        auto n1 = nodes.top(); nodes.pop();
        auto n2 = nodes.top(); nodes.pop();

        nodes.push(n2->linkTo(n1));
      }

      return nodes.top();
    }
  }
};

template<class T>
class Heap {
  Node<T> *root;

  public:
  Heap() : root(nullptr) { }

  T top() const {
    return root->getKey();
  }

  void pop() {
    root = root->mergedSons();
  }

  void insert(const T& key) {
    auto singleton = new Node<T>(key);
    root = singleton->linkTo(root);
  }
};

int main() {
  Heap<int> heap;
  int mode;

  while(EOF != (scanf("%d", &mode))) {
    switch(mode) {
      case 0:
        int value;
        scanf("%d", &value);
        heap.insert(value);
        break;
      case 1:
        printf("%d\n", heap.top());
        break;
      case 2:
        heap.pop();
        break;
    }
  }
}
