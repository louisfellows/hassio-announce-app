using CliWrap;
using CliWrap.Buffered;
using System.Reflection.Metadata.Ecma335;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapPost("/", async (PlayRequest playRequest) =>
{
    Console.WriteLine(playRequest.Uri);

    if (string.IsNullOrEmpty(playRequest.Uri))
    {
        Console.WriteLine("No Uri Supplied");
    }

    var result = await Cli.Wrap("mpg123").WithArguments(playRequest.Uri).ExecuteBufferedAsync();

    if (!result.IsSuccess)
    {
        return Results.Problem();
    }

    return Results.Ok();
})
.WithName("PlayAnnouncement");

app.Run();

internal record PlayRequest(string Uri);