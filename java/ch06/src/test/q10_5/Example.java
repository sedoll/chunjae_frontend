package test.q10_5;

public class Example {
    public static void main(String[] args) {
        A aa = new A();
        System.out.println(aa instanceof A);
        System.out.println(aa instanceof B);
        System.out.println(aa instanceof C);
        System.out.println(aa instanceof D);

        A ad = new D();
        System.out.println(ad instanceof A);
        System.out.println(ad instanceof B);
        System.out.println(ad instanceof C);
        System.out.println(ad instanceof D);
    }
}
