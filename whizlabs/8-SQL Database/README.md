# Lab Details

## Task 1: Login to Azure Portal

## Task 2: Create a Azure SQL Database
1.  On the Azure portal menu or from the Home page, select **Create a resource**.  

    ![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image2.png)

2.  On the New page, select **Databases** in the **Azure Marketplace** section, and then click **SQL Database** in the Featured section.   

![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image5.png)

3.  Fill out the **SQL Database** form with the following information
-   Resource group: Select **resource group_XXXXX**
-   Database name: Enter **_WhizDatabase_**
_![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image4.png)
4.  Click on **Create new** and fill out the **New server** form with the following information:
-   Server name: Enter some unique name
    - **Note**: Server name must be unique
-   Server admin login: Enter **_WhizlabAdmin_**
-   Password: Enter **_Whizlab_123_**
-   Confirm Password: Enter **_Whizlab_123_**
-   Location: Select **East US**
**![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image7.png)
5.  Click **Ok**
6.  Click on **Configure database** in the **Compute + storage** section  
    ![](https://play.whizlabs.com/frontend/web/media/2022/03/24/2022-03-24_10_20_11-create_sql_database_-_microsoft_azure.png)
    
7.  In the **Compute tier** select **Serverless   
    ![](https://play.whizlabs.com/frontend/web/media/2022/03/24/2022-03-24_10_31_40-configure_-_microsoft_azure.png)** 
8.  Click on **Apply**
9.  In the **Backup Storage redundancy** select **Locally-redundant backup storage  
    ![](https://play.whizlabs.com/frontend/web/media/2022/03/24/2022-03-24_11_03_34-create_sql_database_-_microsoft_azure.png)
    
10.  Now that you've completed the SQL Database form, click **Review + Create** and then click on **Create** to provision the database. This step may take a few minutes.  
    ![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image6.png)
    
11.  On the toolbar, click Notifications to monitor the deployment process.

## Task 3: Create a server-level IP firewall rule
1.  After the deployment completes, select **SQL databases** from thezure portal menu or search for and select **SQL databases** from the page.
2.  Select **WhizDatabase** on the SQL databases page. The overview page for your database opens, showing you the fully qualified **Server name** (such as **whizlabserver01.database.windows.net**) and provides options for further configuration.![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image9.png)
3.  Click **Set server firewall** on the toolbar. The Firewall settings page for the server opens.
4.  Click **Add client IP** on the toolbar to add your current IP address to a new IP firewall rule. An IP firewall rule can open port 1433 for a single IP address or a range of IP addresses.
5.  Click Save. A server-level IP firewall rule is created for your current IP address opening port 1433 on the server.![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image8.png)
6.  Click OK and then close the Firewall settings page.

## Task 4: Connect to the database
1.  Click on **Query editor** from left hand side menu bar  
    ![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image12.png)
    
2.  Enter **_Whizlab_123_** in password box and then click on **ok**  
    ![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image10.png)
    

## Task 5: Create tables in the database
1.  In the query window, paste the following query to create four tables in your database and then click on **run.** You will get the **Query succeeded** message.
```
**-- Create Person table**

**CREATE TABLE Person**

**(**

 **PersonId INT IDENTITY PRIMARY KEY,**

 **FirstName NVARCHAR(128) NOT NULL,**

 **MiddelInitial NVARCHAR(10),**

 **LastName NVARCHAR(128) NOT NULL,**

 **DateOfBirth DATE NOT NULL**

**)**

 

**-- Create Student table**

**CREATE TABLE Student**

**(**

 **StudentId INT IDENTITY PRIMARY KEY,**

 **PersonId INT REFERENCES Person (PersonId),**

 **Email NVARCHAR(256)**

**)**

 

**-- Create Course table**

**CREATE TABLE Course**

**(**

 **CourseId INT IDENTITY PRIMARY KEY,**

 **Name NVARCHAR(50) NOT NULL,**

 **Teacher NVARCHAR(256) NOT NULL**

**)**

 

**-- Create Credit table**

**CREATE TABLE Credit**

**(**

 **StudentId INT REFERENCES Student (StudentId),**

 **CourseId INT REFERENCES Course (CourseId),**

 **Grade DECIMAL(5,2) CHECK (Grade <= 100.00),**

 **Attempt TINYINT,**

 **CONSTRAINT [UQ_studentgrades] UNIQUE CLUSTERED**

 **(**

 **StudentId, CourseId, Grade, Attempt**

 **)**

**)**
```

![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image11.png)

2.  Click on the **Tables** tab to view the all the four table that you created.  
    ![](https://play.whizlabs.com/frontend/web/media/2021/09/16/image13.png)
    

# Completion and Conclusions
1.  You have successfully logged into **Azure Portal**.
2.  You have successfully created an Azure SQL Database.
3.  You have successfully created a server-level IP firewall rule.
4.  You have successfully connected to the database.
5.  You have successfully created four database tables.

---
### Links
- https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add#53782560
