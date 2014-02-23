import java.rmi.Naming;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class RMIDemoClient {

    public static void main(String[] args) throws Exception {
        if (args.length == 2) {
            String url = new String("rmi://" + args[0] + "/RMIDemo");
            RMIDemo rmiDemo = (RMIDemo) Naming.lookup(url);
            String serverReply = rmiDemo.doCommunicate(args[1]);
            System.out.println("Server Reply: " + serverReply);
        }
    }
}
