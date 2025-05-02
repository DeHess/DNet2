using Grpc.Core;
using gRPCService;
using System.Text.Json;

namespace gRPCService.Services;

public class GreeterService : Greeter.GreeterBase
{
    private readonly ILogger<GreeterService> _logger;
    private readonly IWebHostEnvironment _env;

    public GreeterService(ILogger<GreeterService> logger, IWebHostEnvironment env)
    {
        _logger = logger;
        _env = env;
    }

    public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
    {
        return Task.FromResult(new HelloReply
        {
            Message = "Hello " + request.Name
        });
    }

    public override async Task<CompetitorReply> GetCompetitors(CompetitorRequest request, ServerCallContext context)
    {
        var jsonPath = Path.Combine(_env.ContentRootPath, "competitors.json");
        var json = await File.ReadAllTextAsync(jsonPath);
        var competitors = JsonSerializer.Deserialize<List<CompetitorItem>>(json);

        var reply = new CompetitorReply();
        reply.Competitors.AddRange(competitors.Select(c => new Competitor
        {
            Name = c.Name,
            Time = c.Time
        }));

        return reply;
    }

    private class CompetitorItem
    {
        public string Name { get; set; }
        public string Time { get; set; }
    }
}