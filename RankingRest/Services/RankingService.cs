using RankingRest.Models;

namespace RankingRest.Services
{
    public class RankingService
    {
        public List<Competitor> GetRankingList()
        {
            string[] ranks = {
                "Mueller Stefan,02:31:14","Marti Adrian,2:30:09",
                "Kiptum Daniel,2:11:31", "Ancay Tarcis,2:20:02",
                "Kreibuhl Christian,2:21:47", "Ott Michael,2:33:48",
                "Menzi Christoph,2:27:26", "Oliver Ruben,2:32:12",
                "Elmer Beat,2:33:53", "Kuehni Martin,2:33:36"
            };

            List<Competitor> rankingList = new List<Competitor>();
            foreach (string r in ranks)
            {
                var parts = r.Split(',');
                Competitor c = new Competitor
                {
                    Name = parts[0],
                    Time = parts[1]
                };
                rankingList.Add(c);
            }
            return rankingList;
        }
    }
}