import java.io._

sealed abstract class Heap[+T <% Ordered[T]] {
	def top : T
	def pop : Heap[T]
	def insert[U >: T <% Ordered[U]](elem : U) : Heap[U] = Heap.link(this, Node(elem, List()))
}

case class Node[T <% Ordered[T]](key : T, children : List[Heap[T]] = List()) extends Heap[T] {
	def top = key
	def pop = Heap.merge(children)
}

case object Empty extends Heap[Nothing] {
	def top = throw new NoSuchElementException("top of empty heap")
	def pop = throw new UnsupportedOperationException("pop on empty heap")
}

object Heap {
	def link[T <% Ordered[T]](lhs : Heap[T], rhs : Heap[T]) : Heap[T] = (lhs, rhs) match {
		case (Empty, _) => rhs
		case (_, Empty) => lhs
		case (Node(lkey, lchd), Node(rkey, rchd)) =>
			if (lkey < rkey) Node[T](lkey, rhs :: lchd)
			else             Node[T](rkey, lhs :: rchd)
	}

	def merge[T <% Ordered[T]](list : List[Heap[T]]) : Heap[T] = list match {
		case List() => Empty
		case List(node) => node
		case first :: second :: rest => link(link(first, second), merge(rest))
	}
}

object Runner {
	def main(args : Array[String]) {
		val br = new BufferedReader(new InputStreamReader(System.in))
		var heap : Heap[Int] = Empty
		var line : String = ""
		while({ line = br.readLine(); line != null}) {
			val tokens = line.split(" ").map(Integer.parseInt(_));
			tokens(0) match {
				case 0 => heap = heap.insert(tokens(1))
				case 1 => println(heap.top)
				case 2 => heap = heap.pop
			}
		}
	}
}
