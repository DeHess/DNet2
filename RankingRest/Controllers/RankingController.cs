using Microsoft.AspNetCore.Mvc;
using RankingRest.Models;
using RankingRest.Services;


namespace RankingRest.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RankingController : ControllerBase
    {
        private readonly RankingService _rankingService;

        public RankingController()
        {
            _rankingService = new RankingService(); 
        }

        [HttpGet]
        public ActionResult<List<Competitor>> Get()
        {
            var ranking = _rankingService.GetRankingList();
            return Ok(ranking);
        }
    }
}
