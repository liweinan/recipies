package StockMarket;

import org.omg.CORBA.ORB;
import org.omg.CosNaming.NameComponent;
import org.omg.CosNaming.NamingContextExt;
import org.omg.CosNaming.NamingContextExtHelper;
import org.omg.PortableServer.POA;
import org.omg.PortableServer.POAHelper;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class UseStockServer {
    public static void main(String args[]) throws Exception {
        System.out.println(args);

        ORB orb = ORB.init(args, null);
        POA rootPOA = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
        rootPOA.the_POAManager().activate();

        StockServerPOAImpl impl = new StockServerPOAImpl();
        impl.setORB(orb);

        org.omg.CORBA.Object ref = rootPOA.servant_to_reference(impl);
        StockServer serverRef = StockServerHelper.narrow(ref);

        org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
        NamingContextExt nameContextExt = NamingContextExtHelper.narrow(objRef);

        String name = "StockServer";
        NameComponent path[] = nameContextExt.to_name(name);
        nameContextExt.rebind(path, serverRef);

        System.out.println("StockServer ready and waiting...");
        orb.run();
    }
}
