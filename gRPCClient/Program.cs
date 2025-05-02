using System;
using System.Threading.Tasks;
using Grpc.Net.Client;
using gRPCService;  // Make sure this matches your csharp_namespace in greet.proto

namespace GrpcClient
{
    class Program
    {
        static async Task Main(string[] args)
        {
            // Connect to the server
            using var channel = GrpcChannel.ForAddress("http://localhost:5203");
            var client = new Greeter.GreeterClient(channel);

            // Call GetCompetitors
            var response = await client.GetCompetitorsAsync(new CompetitorRequest());

            // Print competitors to console
            Console.WriteLine("Competitors:");
            foreach (var competitor in response.Competitors)
            {
                Console.WriteLine($"Name: {competitor.Name}, Time: {competitor.Time}");
            }
        }
    }
}
