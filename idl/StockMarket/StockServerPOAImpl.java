package StockMarket;

import org.omg.CORBA.ORB;

/**
 * @author <a href="mailto:l.weinan@gmail.com">Weinan Li</a>
 */
public class StockServerPOAImpl extends StockServerPOA {

    private ORB orb;

    public void setORB(ORB orb_val) {
        orb = orb_val;
    }

    @Override
    public float getStockValue(String symbol) {
        System.out.println("#SYMBOL# - " + symbol);
        return 0;
    }

    @Override
    public String[] getStockSymbols() {
        String[] val = {"ABC"};
        return val;
    }
}
