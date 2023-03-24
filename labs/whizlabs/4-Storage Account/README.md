# Lab Details

# Lab 4
## Task Summary
1.  Launching Lab Environment
2.  Understand the performance, redundancy and access tiers
3.  Create a Storage Account
4.  Create a Container
5.  Upload a Blob object
6.  Create a File Share
7.  Upload a File

---
## Task 1: Login to Azure Portal

1.  If you have logged into any other Azure Account from previous labs or your own account, please logout of it.
    
2.  Click on the ![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image1.png) button.
    
3.  Once the lab creation process is completed, you can see your _username_ and _password_.
    
4.  Open a browser tab in incognito mode. Go to the Azure portal by clicking on the ![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image22.png) button or by using URL [https://portal.azure.com](https://portal.azure.com/) in incognito mode. 
    
    -   **Note**: It is recommended to use incognito mode to avoid Azure portal cache related issues.
        
5.  If it automatically logs into any other azure account, please logout of it and clear cache.
    
6.  Sign in with your given **_username_** and **_password_** on azure portal.
    
7.  If login is not working. Click and End Lab and start the lab again.
    

## Task 2: Understand the performance, redundancy, and access tiers

1.  **Performance:-** There are many kinds of storage accounts available in Azure Storage. Each type has its own set of features and pricing structure. Before you create a storage account, think about these distinctions to figure out which kind of account is ideal for your needs.
    

![](https://play.whizlabs.com/frontend/web/media/2021/08/10/image6.png)

  Premium block blobs, Premium file shares, and premium page blobs will be available when you choose **Premium** Performance while creating the storage account

![](https://play.whizlabs.com/frontend/web/media/2021/08/10/image5.png)

2. **Redundancy :-**

There are different types of replications that you can perform in Azure. They are:-

**LRS:-** In the main region, locally redundant storage (LRS) duplicates your data three times inside a single data center. This kind of redundancy is useful for Rack Failures within the data center

**ZRS:-** Your Azure Storage data is replicated synchronously across three Azure availability zones in the main region using zone-redundant storage (ZRS). Each availability zone is a physical location with its own power, cooling, and networking infrastructure. This kind of redundancy is useful for data center failures

**GRS:-** Using LRS, geo-redundant storage (GRS) replicates your data three times synchronously inside a single physical location in the primary region. It then asynchronously replicates your data to a single physical place in a secondary area hundreds of kilometers distant from the original region. This kind of is useful for regional failures 

**GZRS:-** GZRS (geo-zone-redundant storage) combines the high availability offered by redundancy across availability zones with the protection afforded by geo-replication against regional failures. Data in a GZRS storage account is duplicated to a secondary geographic area for disaster recovery and is replicated across three Azure availability zones in the original region. If an availability zone becomes inaccessible or unrecoverable, you may still read and write data using a GZRS storage account.

The table below describes when to use what kind of replications

![](https://play.whizlabs.com/frontend/web/media/2021/08/10/image2.png)

3. **Access Tiers:-** 

Different access levels in Azure storage enable you to store blob object data in the most cost-effective way possible. Tiers of access are available, including:

**Hot** - Designed for storing data that is regularly accessed.

**Cool** - Designed to store data that is viewed rarely and kept for at least 30 days.

There is one more tier called the **archive tier**.

We can change the access tier to archive from Hot/Cold. We can’t mention the storage account blob as an archive directly while creating the storage account 

## Task 3: Create a storage account

1.  At the top of the Azure portal, in the search box, search **Storage account**. Select **Storage accounts** in the search results.
    

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image21_27_40.jpg)

2.  In **Storage accounts**, select **+ Create**.
    

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image12.jpg)

3.  In **Create a storage account** page, enter or select the following information in the **Basics** tab:
-   Resource group : Select **resource group_XXXXX**
-   Instance details :
    -   Storage account name : Enter **_mystorageacc[your name]_**
    -   Region : Select **(US) Central US**
    -   Performance : Select **Standard**
    -   Redundancy : Select **Locally-redundant storage (LRS)**

**![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image10.jpg)**

4.  Leave all the settings as default and click on **Review + create**. Then, click on **Create**. Your deployment will be completed after a few minutes.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image23.png)

## Task 4: Create a Container

1.  In the Azure portal, go to the Storage account you created earlier. On the overview page of your storage account, in the **Data storage** section, select **Containers**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image15.jpg)

2.  Click on **+ Container**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image11.jpg)

3.  Now, on the **New Container** page, enter or select the following information :

-   Name : Enter **_mycontainer25_**
-   Public access level : Select **Private (no anonymous access)**
-   Click on **Create**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image7.jpg)

4.  Your container will be created and displayed in the containers section.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image20.png)

## Task 5: Upload a Blob object

1.  First, let us create a simple HTML file. Open **Notepad** on your local computer and enter ```
```
<h1>This is a sample document!</h1>
```

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image5.png)

2.  Then , click on **Save as** and enter **_sample.html_** and click on **Save**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image9.png)

3.  Now, if you try to open the sample.html file, you will see the page displaying the contents in it.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image18.png)

4.  Now, go to the container you created. Here, in the overview page of your container, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image6.jpg)

5.  On the **Upload blob** page, browse the file you created previously named **sample.html** on your local computer and select the file. Then, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image14.jpg)

6.  You can now see that you have your file in place.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image16.png)

## Task 6: Create a File Share

1.  In the Azure portal, go to the Storage account you created earlier. On the overview page of your storage account, in the **Data storage** section, select **File shares.** 

**![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image9_54_10.jpg)**

2.  Click on **+ File share**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image4_54_44.jpg)

3.  Now, on the **New file share** page, enter or select the following information :

-   Name : Enter **_myfile123_**
-   Tier : Select **Hot**
-   Click on **Create**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image8_55_12.jpg)


4.  Your file share will be created and displayed in the file shares section.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image11.png)

## Task 7: Upload a File 

1.  Now, go to the file share you created. Here, in the overview page of your file share, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image25.jpg)

2.  On the **Upload files** page, browse any file on your local computer and select the file. Then, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image5_56_45.jpg)

3.  You can now see that you have your file in place.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image18.jpg)

# Completion and Conclusions

1.  You have successfully logged into Azure Portal.
2.  You have successfully Understood the main things regarding the creation of a storage account such as Performance, Redundancy and the access tiers.
3.  You have successfully configured and created the storage account.
4.  You have successfully created a container.
5.  You have successfully uploaded a blob object.
6.  You have successfully created an azure file share.
7.  You have successfully uploaded a file.