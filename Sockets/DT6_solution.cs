// Raphael Mailänder, Pascal Haupt
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace DT6
{
    // Client app is the one sending messages to a Server/listener.   
    // Both listener and client can send messages back and forth once a   
    // communication is established.  
    public class SocketClient
    {

        public static int Main(String[] args)
        {
            Received += (arg) => Console.Write("Received:" + arg);
            Task.Run(() => StartClient());
            Thread.Sleep(1000);
            Console.ReadKey();
            return 0;
        }

        public static event Action<string> Received;

        public static void StartClient()
        {
            IPAddress ipAddress = IPAddress.Parse("127.0.0.1");
            IPEndPoint remoteEP = new IPEndPoint(ipAddress, 8000);
            byte[] bytes = new byte[1024];

            // Create a TCP/IP  socket.    
            Socket socket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            try
            {
                // Connect to Remote EndPoint  
                socket.Connect(remoteEP);

                Console.WriteLine("Socket connected to {0}", socket.RemoteEndPoint.ToString());


                using (var stream = new NetworkStream(socket))
                {
                    foreach (string line in ReadLines(stream, Encoding.ASCII))
                    {
                        Received.Invoke(line + '\n');
                    }
                }
                


                // Release the socket.    
                socket.Shutdown(SocketShutdown.Both);
                socket.Close();

            }
            catch (ArgumentNullException ane)
            {
                Console.WriteLine("ArgumentNullException : {0}", ane.ToString());
            }
            catch (SocketException se)
            {
                Console.WriteLine("SocketException : {0}", se.ToString());
            }
            catch (Exception e)
            {
                Console.WriteLine("Unexpected exception : {0}", e.ToString());
            }
        }

        static IEnumerable<string> ReadLines(Stream source, Encoding encoding)
        {
            using (StreamReader reader = new StreamReader(source, encoding))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    yield return line;
                }
            }
        }
    }
}