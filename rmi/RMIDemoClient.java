import java.rmi.Naming;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class RMIDemoClient {

    public static void main(String[] args) throws Exception {
        String url = new String("rmi://localhost/RMIDemo");
        RMIDemo rmiDemo = (RMIDemo) Naming.lookup(url);
        String serverReply = rmiDemo.doCommunicate("Apple");
        System.out.println("Server Reply: " + serverReply);
    }
}
