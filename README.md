# Storage_guard

## Description:


The project aims to develop a device for monitoring the conditions surrounding stored and transported goods throughout the supply chain. This is done to ensure user protection from spoiled products such as medicines and food. The methodology followed in this project consists of three main steps.

* Step 1: This step involves the production of the product and the installation of a label containing a Quick Response (QR) code on the box that contains the product or on the product itself, depending on the distribution method. This code contains a link that provides information about the product, including its type, manufacturer, specifications, and the environmental conditions.

* Step 2: This step involves the transportation and storage of the products. In this step, all the QR codes are read, and these products are connected to a device that monitors the temperature and humidity surrounding them. This information is stored in the product-related database.

* Step 3: This step involves the customer. When the customer comes to the store, they can open their mobile phone and scan the QR code of the product they wish to purchase. Through this code, the customer can know how the product has been stored, transported, and whether it is safe for human consumption.

Regarding the tools used in this project, we will be using ESP32, DHT11, OLED 0.96, in addition to several other device-related components. In terms of software, we have developed a consumer application, a device user application, and a backend application for storage and process linking.

### Project scenario

![Alt Text](Diagrams/scenario.png)

###### This diagram shows the scenario of this project

### Block diagram

![Alt Text](path/to/block_diagram.png)

###### This Block diagram of the project