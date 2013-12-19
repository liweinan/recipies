
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public interface ChatServer extends Remote {
    void registerChatClient(ChatClient chatClient) throws RemoteException;
    void broadcastMessage(String message) throws RemoteException;
}
