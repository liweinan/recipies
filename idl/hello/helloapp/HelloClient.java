package helloapp;

import org.omg.CORBA.ORB;
import org.omg.CosNaming.NamingContextExt;
import org.omg.CosNaming.NamingContextExtHelper;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class HelloClient {

    static Hello helloImpl;

    public static void main(String args[]) {
        try {
            for (String arg : args) {
                System.out.println("> " + arg);
            }

            // create and initialize the ORB
//  ORB orb = ORB.init(args, null);
            String[] argumets = { "-ORBInitialPort", "1050", "-ORBInitialHost", "localhost" };
            ORB orb = ORB.init(argumets, null);



            // get the root naming context
            org.omg.CORBA.Object objRef =
                    orb.resolve_initial_references("NameService");
            // Use NamingContextExt instead of NamingContext. This is
            // part of the Interoperable naming Service.
            NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

            // resolve the Object Reference in Naming
            String name = "Hello";
            helloImpl = HelloHelper.narrow(ncRef.resolve_str(name));

            System.out.println("Obtained a handle on server object: " + helloImpl.toString());
            System.out.println(helloImpl.sayHello());

            helloImpl.shutdown(); // oneway test

        } catch (Exception e) {
            System.out.println("ERROR : " + e);
            e.printStackTrace(System.out);
        }
    }
}
