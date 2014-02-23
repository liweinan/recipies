import java.rmi.Naming;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class RMIDemoServer {
    // http://www.youtube.com/watch?v=3fq4AdaiGFA
    public static void main(String[] args) throws Exception {
        RMIDemoImpl rmiDemoImpl = new RMIDemoImpl();
        Naming.rebind("RMIDemo", rmiDemoImpl);
        System.out.println("RMIDemo object bound to the name 'RMIDemo' and is ready for use...");
    }
}
