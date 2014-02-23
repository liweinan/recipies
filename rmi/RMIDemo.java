import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public interface RMIDemo extends Remote {
    public String doCommunicate(String name) throws RemoteException;
}
