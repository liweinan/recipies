import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.List;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class ChatServerImpl extends UnicastRemoteObject implements ChatServer {

    private List<ChatClient> chatClients;

    protected ChatServerImpl() throws RemoteException {
        chatClients = new ArrayList<ChatClient>();
    }

    @Override
    public void registerChatClient(ChatClient chatClient) throws RemoteException {
        this.chatClients.add(chatClient);
    }

    @Override
    public void broadcastMessage(String message) throws RemoteException {
        int i = 0;
        while (i < chatClients.size()) {
            chatClients.get(i++).retrieveMessage(message); // also a remote call
        }
    }
}
