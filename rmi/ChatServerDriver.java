import java.rmi.Naming;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class ChatServerDriver   {
    public static void main(String[] args) throws Exception {
        Naming.rebind("RMIChatServer", new ChatServerImpl());
    }
}
