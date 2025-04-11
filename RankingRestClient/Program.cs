using System.Net.Http.Json;

HttpClient client = new HttpClient();

string apiUrl = "http://localhost:5286/api/ranking";

try
{
    Console.WriteLine("Lade Rangliste...");

    var competitors = await client.GetFromJsonAsync<List<Competitor>>(apiUrl);

    if (competitors != null)
    {
        Console.WriteLine("\n Rangliste:");
        foreach (var c in competitors)
        {
            Console.WriteLine($"{c.Name,-20}  Zeit: {c.Time}");
        }
    }
    else
    {
        Console.WriteLine("Keine Daten erhalten.");
    }
}
catch (Exception ex)
{
    Console.WriteLine($"Fehler beim Abrufen der Daten: {ex.Message}");
}

public class Competitor
{
    public required string Name { get; set; }
    public required string Time { get; set; }
}
