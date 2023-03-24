# Lab Steps

## Task 1: Sign in to Azure Portal

1.  Go to the Azure portal by clicking on the ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/open_console_00_07.png) button or by using URL [https://portal.azure.com](https://portal.azure.com/).
    -   **Note**: It is recommended to use incognito mode to avoid Azure portal cache related issues.
2.  If it automatically logs into any other azure account, please logout of it and clear cache.
3.  Sign in with your given **_username_** and **_password_** on Azure portal.
4.  If login is not working. Click on ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/end lab_00_21.png) and start the lab again.

## Task 2: Create Virtual Machine using Azure CLI 

1.  First you have to click on the Azure Cloud shell icon in Azure Portal.

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022_02_09_14_05_32_home_microsoft_azure.jpg)

2.  Click on **Bash**.

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/image5_27_04_47_06.png)

3.  Click on the **Show Advanced Settings** option
 ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2d.png)
4. You have to fill in the details that are shown for mounting the storage account :

5. After Filling in all the details, click on **Create Storage** and wait for some time.

-   Leave **Subscription** and **Cloud Shell region** as it is.
-   For the **Resource group** : Use existing Resource Group and use the **resource group_XXXXX**
-   For details of the **Storage Account** : 
    -   Click on **Create New** and give a globally unique name for the storage account.
-   For details of the **File share** : 
    -   Click on **Create New** and give a name for the file share.

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022_02_09_14_19_40_.jpg)

6.  After some time you will be able to see an Image like this.

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022-02-09_14_23_35-home_-_microsoft_azure.png)

7.  If you are getting a warning on bash, you can ignore it and continue with the lab.
    ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/1.png)
8.  Now coming to the main part of creating the virtual machine:
    -   You can create a virtual machine using the command “**az vm create**” and you can specify the parameters after that with the sign “**--**”

9.  Use the command given below and fill in the correct parameters like **resource group** etc. You need to replace the resource group name with the one you used above while creating the storage account. Copy the command below and paste it in your CLI.

```
az vm create --resource-group <myResourceGroup> --name myVM --image win2022datacenter --size Standard_B1s --public-ip-sku Standard --admin-username azureuser
```

-   There are many other parameters that can be mentioned like public ip address etc.
-   But the parameters that are mentioned are good enough for the creation of a virtual machine.

10.  After executing the command, you will see that it asks for **Admin Password**. Enter a password and then re-enter when asked for **Confirm Password**.
 
![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022_10_18_19_48_19_resource_groups_microsoft_azure.png)

Then wait for the virtual machine to be created. It may take much more time than creating other resources because there are sub-resources that are created like Network Security Group, IP Address. Network Interface Card, Virtual Network and subnet.

11.  After creating the virtual machine, you can see something like this on the Azure CLI.

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022-02-09_15_24_59-resource_groups_-_microsoft_azure.png)

## Task 3: Attaching the Disks to the Created Virtual Machine

1.  Now as the VM is created it’s time to attach the disk to the virtual machine that we have created

2.  The command is as follows: 

```
az vm disk attach --resource-group <resource group name> --vm-name <virtual machine name> --name <name of disk> --size-gb <size of disk in integer> --sku Premium_LRS --new
```

![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022-02-09_15_23_08-resource_groups_-_microsoft_azure.png)

## Task 4: RDP into Virtual Machine

1.  Go to the **Virtual Machine** section from the left panel menu.

2.  You can see your virtual machine in the list, just click on it and you can see virtual machine details on your screen.


![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022-02-09_15_27_34-myvm2_-_microsoft_azure.png)

3.  Click on the ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/image12_38_19.png) button, and select **RDP**. you can see your RDP connection details.  
    ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022_02_09_15_27_48_myvm2_microsoft_azure.jpg)
4.  **Windows PC**: 

    -   If you are a windows user, download the RDP file from the button **Download RDP File**.

    -   Connect to your virtual machine with your administrator **_username_** and **_password_** which you entered while creating the virtual machine.  

        ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2022_02_09_15_28_24_.jpg)
        
5.  Linux or MAC PC: 
    
    -   If you are using a Linux or MAC PC, you need to [download RDP software](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients) and install it.

    -   Once installed open the software and click on **Add PC.**

    -   Connect your virtual machine using public IP Address and click on **Add**.

    -   Right-click and open the PC, Enter **_username_** and **_password_** in the pop-up and click on Continue in all further popups.
        
6.  After successful login on the virtual machine, wait until Windows boots and is ready to use.
    
    -   If you see this message **Do you want to allow your PC to be discoverable by other PCs and devices on this network?** Just click on **Yes**.
        
7.  Now your virtual machine is ready to use and you can look around inside the new Windows Virtual Machine. 
    
    ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/image11_33_27.png)
    

## Task 5: Setting Up the Disk

1.  Now in your virtual environment, go to the **Server Manager Dashboard** -> **File Storage and services** 
    
    **![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/2.png)**
    
2.   Right Click on the Disk that you have created and click on “**New Volume**”.
    
    ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/3.png)
    
3.  Keep everything as it is in the pop-up menu and click on next until the Ok button appears and then click on **Create.**
    
4.  Now if you go to the **file manager,** you can observe that a new Disk Drive is created.
    
    ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/4.png)
    

# Completion and Conclusions

1.  You have successfully logged into Azure Portal.
    
2.  You have successfully configured and created windows virtual machine using Azure CLI.
    
3.  You have successfully attached the New Managed Data Disk to the Virtual Machine
    
4.  You have successfully made an RDP connection into a new virtual machine that you created
    
5.  And at last, you have successfully configured the Data Disk that you have created.
    

# End Lab

1.  You have successfully completed this lab.
    
2.  Click on **Logout** in Azure Portal by clicking on the logout button in the top right corner inside Azure Profile.
    
3.  Click on ![](https://labresources.whizlabs.com/ad3432a093d959b25c3e112c7c586153/end_lab.png) once you have completed the Lab.