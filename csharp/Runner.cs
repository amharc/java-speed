using System;

public class Runner {
  public static void Main(String[] args) {
    Heap<int> heap = new Heap<int>();
    
    String line;
    while((line = Console.ReadLine()) != null) {
      String[] tokens = line.Split();
      int mode = Int32.Parse(tokens[0]);

      switch(mode) {
        case 0:
          int val = Int32.Parse(tokens[1]);
          heap.Insert(val);
          break;
        case 1:
          Console.WriteLine(heap.Top());
          break;
        case 2:
          heap.Pop();
          break;
        }
    }
  }
}
