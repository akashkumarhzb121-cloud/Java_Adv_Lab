import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
public class Calculatorimpl
        extends UnicastRemoteObject 
            implements Calculator {
    Calculatorimpl() throws RemoteException {
        super();
    }
    public int add(int a, int b)  {
        return a + b;
    }

    public int subtract(int a, int b)  {
        return a - b;
    }
}