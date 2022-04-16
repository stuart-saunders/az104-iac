# AZ104 - Lab 2
## Task 1: Log in to the Azure Portal

## Task 2: Create an Azure Linux Virtual Machine
1.  Search for **virtual machines** in the search bar present in the Azure portal. 
2.  Click on **Virtual Machine Blade** and then Click on **Create** button.
3.  In the **Basics** tab, 
    -   Resource group: Select **resource group_xxxxxx**
    -   virtual machine name: Enter _**myvm123**_
    -   Region: select **East-US**
    -   Image: select **Ubuntu Server 20.04 LTS - Gen 2**
    -   Size: Click on **see all sizes** then select **B2s** and then click on **select** 
    -   Authentication type: select **SSH Public Key** 
	    -   Username: Enter **_WhizlabUser_**
        -   SSH Public Key resource: select **generating a new key pair** 
        -   Key pair name: Enter _**whizkeypair**_
    -   Leave the Inbound Port rules as it is, no need to change anything  
        ![](https://play.whizlabs.com/frontend/web/media/2022/04/09/332_update.png)

 ![](https://play.whizlabs.com/frontend/web/media/2022/04/09/332_update2.png) 

1.  In the **Disks** tab,    
	-   OS Disk Type: Select **Standard SSD**   
    -   Encryption type: select **Default**
    -   Leave everything else as it is
        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_13_51_29_create_a_virtual_machine_microsoft_azure.jpg)

2.  In the **Networking** tab leave everything as default. 
3.  In the **Management** tab,
    -   Boot diagnostics: Select **Disable**
    -   Leave everything as it is

        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_13_53_17_create_a_virtual_machine_microsoft_azure.jpg)
        
4.  Leave everything in the **Advanced** tab as it is.
5.  Click on the **Review + Create** button and click on **Create** button.
6.   Click on Download **Private Key** and create the resource
    ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_13_54_41_create_a_virtual_machine_microsoft_azure.jpg)
    
7.  Wait Until the Deployment is Completed.
8.  After you see something like the image below
    -   Click on **Go to Resource** Button

![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_11_48_.jpg)

## Task 3: Install Nginx web server using custom script extensions
1.  Go to the **Extensions** blade 
    -   Click on **Add** 
    -   On the **Install extension** tab,click on **Custom Script for Linux** and then click on **Next**

        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_13_15_myvm123_microsoft_azure.jpg)  
          
          
        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_14_15_install_an_extension_microsoft_azure.jpg)
        
2.  Now it will display a page, click on **Browse**.  
    ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_17_43_configure_custom_script_for_linux_extension_microsoft_azure.jpg)
    
3.  Click on **Create Storage Account**
    -   Give a Unique name for the storage account
    -   Click on **Ok**
    -   Now wait for some time until the storage account is created.  
        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_21_29_create_storage_account_microsoft_azure.jpg)
        
4.  Now select the Storage account created
    -   Now click on **create a container**
    -   Give a name for the container
    -   Choose **public level access as Blob level**
    -   Click on **Create  
        ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_23_27_new_container_microsoft_azure.jpg)**
5.  Using notepad or any other file editor, save the following text in it and name it as **commands.sh**

`apt-get update -y && apt-get upgrade -y && apt-get install -y nginx`
  
![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022-02-08_11_07_15-commands.sh_-_notepad.png)

7. Now select the created container and upload the file you created above using notepad.  
![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_26_54_.jpg)

8.  Select the uploaded file and in the command section, give the following command and click on **Review + create** and then click on **Create** button. 

`sh commands.sh`

![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_30_30_configure_custom_script_for_linux_extension_microsoft_azure.jpg)

 10.  Wait Until the deployment is completed and succeeded.

## Task 4: Opening Port 80 and test the created virtual machine
1.  Go to the **Networking blade** in your virtual machine and click on  ![](https://play.whizlabs.com/frontend/web/media/2021/09/03/image4_02_59.png) 
2.  After clicking on the add inbound port rule, in the **Destination port ranges** give the port as **port 80** and leave the other settings as default.  
3.  Name the port as **Port 80** and click on **Add.  
    ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_32_50_add_inbound_security_rule_microsoft_azure.jpg)**
4.  Wait for some time until the security rule is added successfully.
5.  Now copy the **Public** **IP address** from the overview page of your virtual machine and paste it in your respective browser.
    ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_34_50_myvm123_microsoft_azure.jpg)
    
6.  You will able to see something like this.  
    ![](https://play.whizlabs.com/frontend/web/media/2022/02/08/2022_02_08_14_36_27_welcome_to_nginx_.jpg)


# Completion and Conclusions
1.  You have successfully logged into **Azure Portal**.
2.  You have successfully configured and created an Azure Linux virtual machine.
3.  You have successfully installed nginx webserver using custom script extensions.
4.  You have successfully opened port 80 and tested the created virtual machine.