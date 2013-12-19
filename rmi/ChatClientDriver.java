import java.rmi.Naming;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class ChatClientDriver {
    public static void main(String[] args) throws Exception {
        String chatServerURL = "rmi://localhost/RMIChatServer";
        ChatServer chatServer = (ChatServer) Naming.lookup(chatServerURL);
        new Thread(new ChatClientImpl(args[0], chatServer)).start();
    }
}
