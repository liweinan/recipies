package StockMarket;


/**
* StockMarket/StockServerOperations.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from StockMarket.idl
* Wednesday, February 19, 2014 2:26:41 AM CST
*/

public interface StockServerOperations 
{
  float getStockValue (String symbol);
  String[] getStockSymbols ();
} // interface StockServerOperations
