
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public interface ChatClient extends Remote {
    void retrieveMessage(String message) throws RemoteException;

}
