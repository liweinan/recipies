// Stub class generated by rmic, do not edit.
// Contents subject to change without notice.

public final class ChatClientImpl_Stub
    extends java.rmi.server.RemoteStub
    implements ChatClient, java.rmi.Remote
{
    private static final long serialVersionUID = 2;
    
    private static java.lang.reflect.Method $method_retrieveMessage_0;
    
    static {
	try {
	    $method_retrieveMessage_0 = ChatClient.class.getMethod("retrieveMessage", new java.lang.Class[] {java.lang.String.class});
	} catch (java.lang.NoSuchMethodException e) {
	    throw new java.lang.NoSuchMethodError(
		"stub class initialization failed");
	}
    }
    
    // constructors
    public ChatClientImpl_Stub(java.rmi.server.RemoteRef ref) {
	super(ref);
    }
    
    // methods from remote interfaces
    
    // implementation of retrieveMessage(String)
    public void retrieveMessage(java.lang.String $param_String_1)
	throws java.rmi.RemoteException
    {
	try {
	    ref.invoke(this, $method_retrieveMessage_0, new java.lang.Object[] {$param_String_1}, -9143462425718454769L);
	} catch (java.lang.RuntimeException e) {
	    throw e;
	} catch (java.rmi.RemoteException e) {
	    throw e;
	} catch (java.lang.Exception e) {
	    throw new java.rmi.UnexpectedException("undeclared checked exception", e);
	}
    }
}
