
/**
* ABCException.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from abc.idl
* Saturday, February 22, 2014 11:37:14 PM CST
*/

public final class ABCException extends org.omg.CORBA.UserException
{

  public ABCException ()
  {
    super(ABCExceptionHelper.id());
  } // ctor


  public ABCException (String $reason)
  {
    super(ABCExceptionHelper.id() + "  " + $reason);
  } // ctor

} // class ABCException
