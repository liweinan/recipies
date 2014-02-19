package StockMarket;

import org.omg.CORBA.ORB;
import org.omg.CosNaming.NamingContextExt;
import org.omg.CosNaming.NamingContextExtHelper;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class StockServerClient {
    static StockServer server;
    public static void main(String args[]) throws Exception {
        ORB orb = ORB.init(args, null);

        // get the root naming context
        org.omg.CORBA.Object objRef =
                orb.resolve_initial_references("NameService");
        // Use NamingContextExt instead of NamingContext. This is
        // part of the Interoperable naming Service.
        NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

        // resolve the Object Reference in Naming
        String name = "StockServer";
        server = StockServerHelper.narrow(ncRef.resolve_str(name));

        System.out.println("Obtained a handle on server object: " + server);
        System.out.println(server.getStockSymbols());
    }
}
