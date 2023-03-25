# Lab Steps

## Task 1: Sign in to Azure Portal

## Task 2: Create Virtual Machine using Azure CLI 

1.  First you have to click on the Azure Cloud shell icon in Azure Portal.
    
    ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022_02_09_14_05_32_home_microsoft_azure_53_36.jpg)
    
2.  Click on **Bash**.
    

![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022_03_04_21_57_40_document1_word.jpg)

3.  Click on the **Show Advanced Settings** option
    

![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/image4_54_22.png)

4. You have to fill in the details that are shown for mounting the storage account :

5. After Filling in all the details, click on **Create Storage** and wait for some time.

-   Leave **Subscription** and **Cloud Shell region** as it is.
-   For the **Resource group** : Use existing Resource Group and use the **resource group_XXXXX**
-   For details of the **Storage Account** : 
    
    -   Click on **Create New** and give a globally unique name for the storage account.
        
-   For details of the **File share** : 
    
    -   Click on **Create New** and give a name for the file share.
        

![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022_02_09_14_19_40__55_27.jpg)

6.  After some time you will be able to see an Image like this.
    

![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022-02-09_14_23_35-home_-_microsoft_azure_55_58.png)

7.  For creating a virtual machine you need to provide the username and password. 
    
    -   One should not specify the username and password in the CLI command directly, Instead, they have to be stored in a variable for security/privacy reasons.
        
    -   For that use the following commands :
        
        username="demouser"  
        password="XXXXXX"
8.  Now coming to the main part of creating the virtual machine:
    
    -   You can create a virtual machine using the command “**az vm create**” and you can specify the parameters after that with the sign “**--**”
        
9.  Use the command given below and fill in the correct parameters like **resource group** etc. You need to replace the resource group name with the one you used above while creating the storage account. Copy the command below and paste it in your CLI.
    
```
az vm create --name MyVm --resource-group resourcegroup_XXXXX --image win2019datacenter --size Standard_B1s --admin-username $username --admin-password $password
```

-   There are many other parameters that can be mentioned like public ip address etc.
    
-   But the parameters that are mentioned are good enough for the creation of a virtual machine.
    
10.  After executing the command, wait for some time until the virtual machine is created.
    -   It may take much more time than creating other resources because there are sub-resources that are created like Network Security Group, IP Address. Network Interface Card, Virtual Network and subnet.

11.  After creating the virtual machine, you can see something like this on the Azure CLI.
    ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022-02-09_13_50_48-settings.png)

## Task 3: RDP into Virtual Machine

1.  Go to the **Virtual Machine** section from the left panel menu.
    
2.  You can see your virtual machine in the list, just click on it and you can see virtual machine details on your screen.

![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022-02-09_13_52_50-myvm_-_microsoft_azure.png)

3.  Click on the ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/image12_57_35.png) button, and select **RDP**. you can see your RDP connection details.  
    ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022_02_09_13_53_32_myvm_microsoft_azure.jpg)
4.  **Windows PC**: 
    
    -   If you are a windows user, download the RDP file from the button **Download RDP File**.
        
    -   Connect to your virtual machine with your administrator _username_ and _password_ which you entered while creating the virtual machine.  
          
        ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/2022_02_09_13_53_32_myvm_microsoft_azure_58_43.jpg)
        
5.  **Linux or MAC PC**: 
    
    -   If you are using a Linux or _MAC_ PC, you need to [download RDP software](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients) and install it.
        
    -   Once installed open the software and click on **Add PC.**
        
    -   Connect your virtual machine using public IP Address and click on **Add**.
        
    -   Right-click and open the PC, Enter _username_ and _password_ in the pop-up and click on Continue in all further popups.
        
6.  After successful login on the virtual machine, wait until Windows boots and is ready to use.
    
    -   If you see this message **Do you want to allow your PC to be discoverable by other PCs and devices on this network?** Just click on **Yes**.
        
7.  Now your virtual machine is ready to use and you can look around inside the new Windows Virtual Machine. 
    
    ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/image11_59_22.png)

## Task 4: Deleting the Resources

-   Note: Deleting the resources after creation which are not useful is an important thing and the best practice in azure.

1.  Go to the all resources button on the left-hand side panel and filter the resources by the resource group you have to create your resources in.
    
2.  Select all the resources.
    
3.  Click on the delete button, This will delete all the resources that you have created.

# Completion and Conclusions

1.  # You have successfully logged into **Azure Portal**.
    
2.  You have successfully configured and created windows virtual machine using Azure CLI.
    
3.  You have successfully made an RDP connection into a new virtual machine that you created.

# End Lab

1.  You have successfully completed this lab.
    
2.  Click on **Logout** in Azure Portal by clicking on the logout button in the top right corner inside Azure Profile.
    
3.  Click on ![](https://labresources.whizlabs.com/a5d65d371cf11829be290ded996bf977/end lab_23_11.png) once you have completed the Lab.