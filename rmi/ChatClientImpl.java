
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.Scanner;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class ChatClientImpl extends UnicastRemoteObject implements ChatClient, Runnable {
    private ChatServer chatServer;
    private String name = null;

    protected ChatClientImpl(String name, ChatServer chatServer) throws RemoteException {
        this.name = name;
        this.chatServer = chatServer;
        chatServer.registerChatClient(this);
    }

    @Override
    public void retrieveMessage(String message) throws RemoteException {
        System.out.println(message);
    }

    @Override
    public void run() {
        Scanner scanner = new Scanner(System.in);
        String message;
        while (true) {
            message = scanner.nextLine();
            try {
                chatServer.broadcastMessage(name + " : " + message);
            } catch (Exception e) {
            }
            ;
        }
    }
}
