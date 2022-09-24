# Lab Details

## Task 1: Login to Azure Portal

## Task 2: Creating Windows Virtual Machine
1.  On the Azure portal menu or from the Home page, select **Create a resource**.  

![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image17.png)
    
2.  In the **Categories** select **Compute** and then Click on **Create** under **Virtual Machine****![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image12.png)

3.  Fill out the **Create a Virtual Machine** basic details form with the following information and then click on **Review + create**
-   Resource group: Select **resource group_XXXXX**
-   Virtual Machine Name: Enter **_WhizlabVM-software_**
-   Image: Select **Windows Server 2019 Datacenter - Gen2**
-   Size: Click on **see all sizes** then select **B2s** and then click on **select** 
-   Username: Enter **_WhizlabUser_**
-   Password: Enter **_User@1234567_**
-   Confirm Password: Enter **_User@1234567_**
-   Leave the other option as default

![](https://play.whizlabs.com/frontend/web/media/2022/04/09/336_update.png)

**Note:** Enter some random email id if asked after this step.

4.  Click on **Create**

## Task 3: Deploying Software with VM Extensions
1.  Once the deployment in complete click on **Go to resource**
 **![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image15.png)** 

2.  Click on **Extensions** from left hand menu bar under the Settings

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image1.png) 

3.  Click on **Add** to attach a extension

![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image14.png)

4.  Click on **Network Watcher Agent for Windows** from the options  
    **![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image4.png)**
    
5.  Click on **Create**
**![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image19.png)**
6.  Click on **Ok**
7.  After few minutes, our VM Extension will get deployed

**Note**: Refresh the page if the Extension is not visible  
![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image10.png)

## Task 4: RDP to Windows VM instance
1.  Go back to **Overview** page from the left hand menu bar

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image8.png) 

2.  Click on **Connect** from the top menu and then select **RDP**

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image13_23_40.png) 

3.  Click on **Download RDP File** and open it once download in complete

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image5.png) 

4.  Click on **Connect  
    ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image2.png)**
5.  Click on **use a different account**
6.  Enter the below details in the page and then click on **Ok**
-   Username: Enter **_WhizlabUser_**
-   Password: Enter **_User@1234567_**
7.  Click on **Yes**
8.  Now you are login into the new windows machine

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image6.png) 

## Task 5: Verifying the deployment
1.  Click on Windows Menu bar and then open **Service Manager**
 **![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image7.png)** 
2.  Click on **Tools**, inside that click on **Services  
    ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image18.png)** 
    
3.  Now you can able to see **Azure Network Watcher Agent** is running

 ![](https://play.whizlabs.com/frontend/web/media/2021/10/17/image16.png) 

# Completion and Conclusions
1.  You have successfully logged into **Azure Portal**.
2.  You have successfully created an Azure Windows VM.
3.  You have successfully deployed Software using VM Extensions.
4.  You have successfully RDP into the Windows VM.
5.  You have successfully verified the deployment of the Azure Network Watcher Agent.

---
### Links
- https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows
- https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/network-watcher-windows