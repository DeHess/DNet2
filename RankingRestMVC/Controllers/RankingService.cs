using Microsoft.AspNetCore.Mvc;
using RankingRestMVC.Services;

namespace RankingRestMVC.Controllers
{
    public class RankingController : Controller
    {
        private readonly RankingService _rankingService;

        public RankingController()
        {
            _rankingService = new RankingService();
        }

        public IActionResult Index()
        {
            var ranking = _rankingService.GetRankingList();
            return View(ranking);
        }
    }
}
