package Random;

import java.util.Scanner;
public class DoubleColorBalls {


    public static void main(String[] args) {
        int RedBalls[] = Random(1, 34, 7);

        System.out.print("红球池：");
        for (int i = 0; i < RedBalls.length - 1; i++) {
            System.out.print(RedBalls[i] + "\t");

        }
        System.out.println();
        System.out.println("篮球：" + RedBalls[6]);

        Scanner scanner = new Scanner(System.in);
        int[] Guess = new int[7];
        int count = 1;
        int num ;
        System.out.println("请输入第" + count + "红球号码");
        for (int i = 0; i < Guess.length - 1; i++) {
            num = scanner.nextInt();
            Guess[i] = num;
            count++;

            if (i > 0) {
                for (int j = 0; j < i; j++) {
                    if (num == Guess[j]) {
                        System.out.println("请输入不同的号码！！");
//                    System.out.println(Guess[j]);
                        i--;
                        count--;
                        break;
                    }
                }
            }

            if (count == 7) {
                System.out.println("请输入篮球的号码");
                num = scanner.nextInt();
                Guess[i + 1] = num;
                break;
            }
            System.out.println("请输入第" + count + "红球号码");
        }

        int RightTimes = 0;
        for (int i = 0; i < Guess.length - 1; i++) {

            for (int j = 0; j < RedBalls.length - 1; j++) {
                if (Guess[i] == RedBalls[j]) {
                    RightTimes++;
                }
            }
        }
        System.out.println(Guess.length + "-----------");
        if (RightTimes == 6 && Guess[6] == RedBalls[6]) {
            System.out.println("猜中了");
        } else System.out.println("没猜中");

        scanner.close();

    }

//    @org.jetbrains.annotations.NotNull
   //生成数字不重复的随机数组
    public static int[] Random(int Min, int Max, int length) {
        int[] Ran = new int[length];

        for (int i = 0; i < Ran.length; i++) {
            int Rand = (int) (1 + Math.random() * (Max - Min + 1));
            Ran[i] = Rand;
            for (int j = 0; j < i; j++) {
                if (Ran[i] == Ran[j]) {
                    i--;
                    break;
                }
            }
        }
        return Ran;
    }
}
