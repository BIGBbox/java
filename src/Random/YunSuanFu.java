package Random;

public class YunSuanFu {

   public static void main(String[] args) {

      int a = 10;
      int b = 10;
      int c = 10;


      a = b++; //a=10 =b11
      c = --a; //c=9 a=9
      b = ++a; //b=10 a=10
      a = c--; //a=9 c=8

      System.out.println(a);
      System.out.println(b);
      System.out.println(c);

   }
}
