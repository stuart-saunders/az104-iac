# AZ104 - Lab 1 - Working with Blob Storage
Task Summary:-
- Create a Storage Account
- Create a Container
- Upload a Blob object
- View the Blob


## Task 1: Login to Azure Portal

1.  If you have logged into any other Azure Account from previous labs or your own account, please logout of it.
2.  Click on the ![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image1.png) button.
3.  Once the lab creation process is completed, you can see your _username_ and _password_.
4.  Open a browser tab in incognito mode. Go to the Azure portal by clicking on the ![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image22.png) button or by using URL [https://portal.azure.com](https://portal.azure.com/) in incognito mode. 
    -   **Note**: It is recommended to use incognito mode to avoid Azure potal cache related issues.
5.  If it automatically logs into any other azure account, please logout of it and clear cache.
6.  Sign in with your given **_username_** and **_password_** on azure portal.
7.  If login is not working. Click and End Lab and start the lab again

## Task 2: Create a Storage Account
1.  At the top of the Azure portal, in the search box, search **Storage account**. Select **Storage accounts** in the search results.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image21_27_40.jpg)

2.  In **Storage accounts**, select **+ Create**.   

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image12.jpg)

3.  In **Create a storage account** page, enter or select the following information in the **Basics** tab:
-   Resource group : Select **resource group_XXXXX**
-   Instance details :
    -   Storage account name : Enter **_mystorageacc[your name]_**
    -   Region : Select **(US) Central US**
    -   Performance : Select **Standard**
    -   Redundancy : Select **Locally-redundant storage (LRS)**
**![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image10.jpg)**
4.  Leave all the settings as default and click on **Review + create**. Then, click on **Create**. Your deployment will be completed after a few minutes.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image23.png)

## Task 3: Create a Container
1.  In the Azure portal, go to the Storage account you created earlier. On the overview page of your storage account, in the **Data storage** section, select **Containers**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image15.jpg)

2.  Click on **+ Container**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image11.jpg)

3.  Now, on the **New Container** page, enter or select the following information :
-   Name : Enter **_mycontainer25_**
-   Public access level : Select **Private (no anonymous access)**
-   Click on **Create**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image7.jpg)

4.  Your container will be created and displayed in the containers section.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image20.png)

## Task 4: Upload a Blob object
1.  First, let us create a simple HTML file. Open **Notepad** on your local computer and enter `<h1>This is a sample document!</h1>`

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image5.png)

2.  Then , click on **Save as** and enter **_sample.html_** and click on **Save**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image9.png)

3.  Now, if you try to open the sample.html file, you will see the page displaying the contents in it.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image18.png)

4.  Now, go to the container you created. Here, in the overview page of your container, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image6.jpg)

5.  On the **Upload blob** page, browse the file you created previously named **sample.html** on your local computer and select the file. Then, click on **Upload**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image14.jpg)

6.  You can now see that you have your file in place.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image16.png)

7.  Now, click on the file which is uploaded to your container. You can see on the **overview** page, there are various properties shown. You can go ahead and click on the **Edit** section and also edit the file here itself. 

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image8.jpg)

8.  You can make some changes in your file if you want and then click on **Save**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image13.jpg)

9.  Now, go to the **overview** section and copy the **URL**. Then, paste it on your browser.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image24.jpg)

10.   You can see that we are getting an error message of a resource not found. And the reason for this is, when you go to a new tab and try to access this blob, you are trying to access this blob as an anonymous user. And by default, anonymous access is not allowed for the blobs in your container. 

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image19.png)

11.  So, let’s change the access level of our container.

## Task 5: Change access level
1.  Go to the **overview** section of your container, and click on **Change access level**.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image4.jpg)

2.  Now, select the following information on the **Change access level** section:
-   Public access level : Select **Blob (anonymous read access for blobs only)**
-   Click on **OK**. 

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image2.jpg)

3.  Now, go back to your browser, and refresh the page. You will now be able to see the contents of the file on the web page displayed.

![](https://play.whizlabs.com/frontend/web/media/2022/02/02/image17.png)

4.  So, finally you accessed the blob within your container.

## Completion and Conclusions
1.  You have successfully logged into **Azure Portal**.
2.  You have successfully created a Storage Account.
3.  You have successfully created a Container.
4.  You have successfully uploaded a Blob object.
5.  You have successfully changed the access level.