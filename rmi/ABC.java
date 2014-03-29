import java.rmi.Remote;

public class ABC implements Remote {

    public String sayHello() {
        System.out.println("Hello, world!");
        return "Hello, world!";
    }
}
