using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers;

[ApiController]
[Route("[controller]")]
public class VacationController : ControllerBase
{
    private readonly IMediator _mediator;

    public VacationController(IMediator mediator)
    {
        _mediator = mediator;
    }


    [HttpGet]
    public async Task<IActionResult> GetUserVacations()
    {

        return Ok();
    }
}
