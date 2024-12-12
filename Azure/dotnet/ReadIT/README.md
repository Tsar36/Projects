# The "Internet Bookshop" project based on .Net >=8 version

### Run the project localy (catalog):
```bash 
dotnet publish -o publish
```
- then your code is ready to deploy to VM.
- configure the local server (IIS) with 'Web server' role.
- Install the 'Hosting Bundles' to the VM.

### Run the project localy (inventory and catalog):
```bash
dotnet build
dotnet run
```
Then open the browser on http://localhost:5002 for the 'inventory' site & open http://localhost:5000/ for the 'catalog' site.

### The Weather API. (OPTIONAL)
- The 'catalog' app contains the widget  of the 'Weather API'. To access it, you need to run a new VM (Ubuntu) in the same place ('Vnet') when 'catalog'.
- In the VM, just run the commands in bash:
``` bash
sudo apt install git
sudo apt update
sudo apt install nodejs
sudo git clone https://github.com/memilavi/weatherAPI.git
cd weatherAPI
sudo apt install npm
npm start
```

## Run the project 'inventory' on the 'Azure App Service'
- Create the Web App on portal.
- Click on "Deploy to Web App" from the left side window.
- Make sure to login and check the status on the Azure portal.

## 'Cart' folder
"It's a shoping cart of the project. The deployment is the similar inventory - local deployment, but contains the another way to deploy to the portal - docker image wich will be leverage with services: ACR and AKS.
Contains: Dockerfile for ACR, and deployment.yml file for AKS."

## 'Order' folder
The most important files in this project are these two:
- the ProcessOrderCosmos and the ProcessOrderStorage.

These two files are basically the two functions that are going to be part of our function app. And one of them is going to process the orders and store them in the Cosmos DB. And the second one is going to store them in storage account.

