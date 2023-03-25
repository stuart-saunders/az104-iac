# Lab Steps

## Task 1: Sign in to Azure Portal   

## Task 2: Create a Web App using Azure CLI

1.  First You have to click on the **Azure Cloud shell** icon in **Azure Portal.**

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/1.png)

2.  Click on **Bash.**

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2b.png)

3.  Click on the **Show Advanced Settings** option.
 
![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2c.png)

4.  You have to fill in the details that are shown for mounting the storage account.
-   Cloud Shell region: Select **Central India**
-   Storage Account: Select **create new** and Enter a globally unique name
-   File Share: Select **create new** and Enter a file share name

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2d.png)

5.  After Filling in all the details, **click** on **Create Storage** and wait for some time.

6.  Now you have your **Bash** terminal running. please **ignore the warning message.**

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2e_27_23.png)

7.  Now for creating a web app in Azure,first you have to create an app service plan. use the **below command** to create **App Service Plan.  

Note: Replace `<resource group name>` with the **already provided resource group name**.

```
az appservice plan create --name <App service plan name> --resource-group <resource group name> --is-linux
```

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2f.png)

8.   Now use the below command to **create a web app** in Azure.  
	**Note:** Enter a **globally unique** web app name.

```
az webapp create --resource-group <resource group name> --plan <App service plan name> --name <web app name> --deployment-container-image-name nginx
```

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/2g.png)

9.   After executing the commands wait for some time until the **app service plan** and **web app** is **created.**
    

## Task 3: Get the Deployed App URL

1.  Click on **App services** in the left-hand panel of the **Azure portal menu.**

	**![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/3a.png)**

2.  **Select** the **WebApp** that you have created.

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/3b.png)

3.  Now **copy the url** of your **web app** and **paste** it in a **new tab.** 
**![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/3c.png)**

4.  You will see **W****elcome to nginx** message.

![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/image5.png)

## Task 4: Understanding Charts

1.  Switch back to the **OverView Page** of Web App Created. If you **scroll down**, You can see **several charts**.
    
    ![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/image3.png)
    
2.  Hit the **App URL 4-5 Times** to simulate the **request-response** cycle.
    
3.  Please **wait for 2-5 minutes** and **refresh** the page if the graph does not show the traffic details.
    
4.  You should be able to see the corresponding telemetry displayed in the charts.
    
5.  These Charts will provide a clear **understanding of traffic** you are getting on the New Web App created.
    
6.  This will include **HTTP 5xx, Data In, Data Out, Requests(Number of requests), Response Time**.
    
7.  Understanding Charts

-   HTTP 5xx Chart: HTTP 5xx responses indicate the server issues. A sudden spike in the number of 5xx responses can be the result of the following:
    
-   Deploying new code which contained a bug.
    
-   Errors returned by upstream services that your application depends on.
    
-   Your application is overwhelmed by the amount of traffic it is receiving.
    
-   Issues in the configuration for your app service.
    
-   Data In: Provides details of incoming data to the Web App.
    
-   Data Out: Provides details of outgoing data from the Web App.
    
-   Requests: Shows details of a number of requests received by Web app over the period of time.
    
-   Response Time: This shows how much time Web App took to respond back to the requests it is receiving over the period of time.
    

# **Completion and Conclusions**

1.  You have successfully logged into Azure portal.
    
2.  You have Successfully Understood how to create a New Web App using Azure CLI
    
3.  You have tested the Web app using App URL.
    
4.  You have understood the app traffic stats and detailed analysis using the charts provided.
    

# **End Lab**

1.  You have successfully completed this lab.
    
2.  Click on **Logout** in Azure Portal by clicking on the logout button in the top right corner inside Azure Profile.
    
3.  Click on ![](https://labresources.whizlabs.com/7d701b958a3e7e7fbc004001fe2e3b31/end_lab.png) once you have completed the Lab.