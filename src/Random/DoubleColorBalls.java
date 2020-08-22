package Random;

import java.util.Scanner;
public class DoubleColorBalls {

    public static void main(String[] args) {
        //因为双色球中蓝球只有一个，为了方便就直接把篮球和红球放在一个数组里了， 获取一个长度为7且数字都不重复的数组
        int RedBalls[] = Random(1, 34, 7);


        //直接遍历输出看下结果，以便测试
        System.out.print("红球池：");
        for (int i = 0; i < RedBalls.length - 1; i++) {
            System.out.print(RedBalls[i] + "\t");
        }
        System.out.println();
        System.out.println("篮球：" + RedBalls[6]);

        //键盘录入数字
        Scanner scanner = new Scanner(System.in);
        int[] Guess = new int[7];
        int count = 1;
        int num ;
        System.out.println("请输入第" + count + "红球号码");
        for (int i = 0; i < Guess.length - 1; i++) {
            num = scanner.nextInt();
            Guess[i] = num;
            count++;

            //输入的数字与之前的相同的话就重新生成
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

            //数组长度到达7时，此时插入的应该为篮球号码
            if (count == 7) {
                System.out.println("请输入篮球的号码");
                num = scanner.nextInt();
                Guess[i + 1] = num;
                break;
            }
            //控制台输出提醒语句
            System.out.println("请输入第" + count + "红球号码");
        }

        //遍历比较玩家输入的号码和随机号码池中的是否相等
        int RightTimes = 0;
        for (int i = 0; i < Guess.length - 1; i++) {

            for (int j = 0; j < RedBalls.length - 1; j++) {
                if (Guess[i] == RedBalls[j]) {
                    RightTimes++;
                }
            }
        }
        System.out.println(Guess.length + "-----------");
        //六个红球的号码都相等，且篮球号码也相等的话则猜中了，否则猜错了
        if (RightTimes == 6 && Guess[6] == RedBalls[6]) {
            System.out.println("猜中了");
        } else System.out.println("没猜中");

        //关闭输入资源
        scanner.close();

    }

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
