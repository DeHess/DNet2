var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}

app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

// Standardroute setzen
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Ranking}/{action=Index}/{id?}");

app.Run();
