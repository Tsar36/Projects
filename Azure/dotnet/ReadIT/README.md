# The "Internet Bookshop" project based on .Net >=8 version

### Run the project localy (catalog):
```bash 
dotnet publish -o publish
```
- then your code is ready to deploy to VM.
- configure the local server (IIS) with 'Web server' role.

### Run the project localy (inventory and catalog):
```bash
dotnet build
dotnet run
```
Then open the browser on http://localhost:5002 for the 'inventory' site & open http://localhost:5000/ for the 'catalog' site.

## Run the project on the 'Azure App Service'
... soon