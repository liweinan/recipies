package StockMarket;


/**
* StockMarket/StockSymbolListHolder.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from StockMarket.idl
* Wednesday, February 19, 2014 2:26:41 AM CST
*/

public final class StockSymbolListHolder implements org.omg.CORBA.portable.Streamable
{
  public String value[] = null;

  public StockSymbolListHolder ()
  {
  }

  public StockSymbolListHolder (String[] initialValue)
  {
    value = initialValue;
  }

  public void _read (org.omg.CORBA.portable.InputStream i)
  {
    value = StockMarket.StockSymbolListHelper.read (i);
  }

  public void _write (org.omg.CORBA.portable.OutputStream o)
  {
    StockMarket.StockSymbolListHelper.write (o, value);
  }

  public org.omg.CORBA.TypeCode _type ()
  {
    return StockMarket.StockSymbolListHelper.type ();
  }

}