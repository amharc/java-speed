import sys

class Node():
    """ Pairing heap node """

    def __init__(self, key):
        self.key = key
        self.children = []

    def link(self, other):
        if other == None:
            return self

        if self.key > other.key:
            return other.link(self)

        self.children.append(other)
        return self

    @classmethod
    def merge_list(cls, children):
        if children == []:
            return None

        if len(children) == 1:
            return children[0]

        rem = cls.merge_list(children[2:])

        return children[0].link(children[1]).link(rem)

    def merged_children(self):
        self.children.reverse()
        new = self.merge_list(self.children)
        self.children = []
        return new

class Heap():
    def __init__(self):
        self.root = None

    def top(self):
        return self.root.key

    def pop(self):
        self.root = self.root.merged_children()

    def insert(self, key):
        self.root = Node(key).link(self.root)

if __name__ == '__main__':
    heap = Heap()

    for line in sys.stdin:
        data = line.split()
        if data[0] == "0":
            heap.insert(int(data[1]))
        elif data[0] == "1":
            print(heap.top())
        else:
            heap.pop()

