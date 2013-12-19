import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class RMIDemoImpl extends UnicastRemoteObject implements RMIDemo {

    protected RMIDemoImpl() throws RemoteException {
        super();
    }

    @Override
    public String doCommunicate(String name) throws RemoteException {
        return "\nServer says: Hi " + name + "\n";
    }
}
