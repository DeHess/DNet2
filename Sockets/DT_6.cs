using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace DT6 {
    // Client app is the one sending messages to a Server/listener.   
    // Both listener and client can send messages back and forth once a   
    // communication is established.  
    public class SocketClient {
        
        public static int Main(String[] args) {
            Received += (arg) => Console.Write("Received:" + arg);
            Task.Run(() => StartClient());
            Thread.Sleep(1000);
            Console.ReadKey();
            return 0;
        }
        
        public static event Action<string> Received;

        public static void StartClient() {
            /* TO BE DONE
            */ 
        }
    }
}