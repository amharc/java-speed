import java.io.*;
import java.util.*;

public class Runner {
  public static void main(String[] args) {
    BufferedReader bw = new BufferedReader(
                          new InputStreamReader(System.in));
    Heap<Integer> heap = new Heap<Integer>();

    String line;
    try {
      while((line = bw.readLine()) != null) {
        String[] tokens = line.split(" ");
        int mode = Integer.parseInt(tokens[0]);

        switch(mode) {
          case 0:
            int value = Integer.parseInt(tokens[1]);
            heap.insert(value);
            break;
          case 1:
            System.out.println(heap.top());
            break;
          case 2:
            heap.pop();
            break;
        }
      }
    } catch (IOException ex) {
      System.err.println("Exception: " + ex.getLocalizedMessage());
    }
  }
}
