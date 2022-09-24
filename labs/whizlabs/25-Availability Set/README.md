# Lab Details

## Task 1: Login to Azure Portal

## Task 2: Creating an Availability Set

1.  The Azure portal menu or from the Home page, select **Create a resource**.  
    ![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image2.png)

2.  Search for **Availability Set** and choose the first option that appears.

![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image3.png)

3.  Click on **Create.**
4.  Fill out the form with the following details:
-   Resource group: Select **resource group_XXXXX**
-   Name: Enter **_WhizAvail_**
_![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image4.png)_
5.  Click on **Review+Create.**
6.  Click on **Create.**

## Task 3: Deploying a Virtual Machine
1.  Now, The Azure portal menu or from the Home page, select **Create a resource**.  
    ![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image2_17_55.png)
2.  In the **Categories** select **Compute** and then Click on **Create** under **Virtual Machine.**
**![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image6.png)**
3.  Fill out the **Create a Virtual Machine** basic details form with the following information
-   Resource group: Select **resource group_XXXXX**
-   Virtual Machine Name: Enter **_WhizlabAvail1_**
-   Availability Options: Select **Availability Set**
-   Availability Set: Select **WhizAvail**
-   Image: Select **Ubuntu Server 20.04 LTS Gen1**
-   Size: Select **See all sizes** and select **B2s** and click on **Select**
-   Authentication type: Select **Password**
-   Username: Enter **_Whizlabavail1_**
-   Password: Enter **_Avail@1234567_**
-   Confirm Password: Enter _**Avail@1234567**_
-   Leave the other option as default

![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image7_27_08.png)

4.  Now Click on **Review + create**
5.  Click on **Create**

## Task 4: Deploying the second Virtual Machine within the same Availability Set
1.   Now, The Azure portal menu or from the Home page, select **Create a resource**.  
    ![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image3_29_08.png)

2.  In the **Categories** select **Compute** and then Click on **Create** under **Virtual Machine.**
**![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image4_29_26.png)**
3.  Fill out the **Create a Virtual Machine** basic details form with the following information
-   Resource group: Select **resource group_XXXXX**
-   Virtual Machine Name: Enter **_WhizlabAvail2_**
-   Availability Options: Select **Availability Set**
-   Availability Set: Select **WhizAvail**
-   Image: Select **Ubuntu Server 20.04 LTS Gen1**
-   Size: Select **See all sizes** and select **B2s** and click on **Select**
-   Authentication type: Select **Password**
-   Username: Enter **_Whizlabavail2_**
-   Password: Enter **_Avail2@1234567_**
-   Confirm Password: Enter _**Avail2@1234567**_
-   Leave the other option as default

![](https://play.whizlabs.org/frontend/web/media/2022/02/17/image5_30_36.png)

4.  Now Click on **Review + create**
5.  Click on **Create**

## Completion and Conclusions
1.  # You have successfully logged into **Azure Portal**.
2.  You have successfully created an Availability Set
3.  You have successfully deployed a Virtual Machine
4.  You have successfully deployed the second Virtual Machine within the same Availability Set

---
### Links
- https://github.com/hashicorp/terraform-provider-azurerm/pull/976