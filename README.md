# flutter_e_commerce

The main purpose of the application is to enter, list and sort e-commerce products. In the application, we select the name, description, price and category of the item and save it to the database. The application is made with flutter and firebase is used for the back-end. Firebase realtime database is used for database.


<h2> Using Flutter </h2>

<h3> Architecture Design Pattern </h3>
<p>
  Getx library is used to manage state and main processes for Flutter. In this library, management proceeds in the form of view-controller-service. Simply the operations are as follows:
  
  <ul>
    <li> The user decides what he wants to do on the UI and clicks wherever he wants and the actions are taken</li>
    <li> The user's action goes to the controller section and the logic operations are performed, and if data is required in this logic operation, it receives the data with the help of the service</li>
    On the <li> Service side, the data is made with database queries or api operations. Sends this data to the controller</li>
    <li> It performs logic operations and updates its data again according to the data from the Controller service</li>
    <li> The View UI is updated according to the data changed by the Controller</li>
  </ul>
</p>

<h3> File Structure </h3>
 
  - /app
    - /get
          </br> #Class where controllers are defined and prepared
        - initial_bindings.dart
          </br> #Controller that controls listing, adding, updating and deleting items
        - shop_get.dart
    - /service
        </br> #With the help of this service, we can perform firebase operations.
      - firebase_service.dart
    - /model
        </br> #Model structure in which listed and used items are kept.
      - shop_item.dart
        </br> #Enum used to keep category of items
      - shop_item_category.dart
    - /view
        </br> #Home page where items can be listed, filtered or sorted and items added
      - main_screen.dart
        </br> #Detail page of the item clicked on the main page, here the item information can be seen in detail and the item can be edited and deleted
      - shop_item_detail.dart
      </br> #Directory where widgets that can be used in different places are listed in a reusable way
  - /widget
        </br> #Class that gives reusable dialog or bottom sheet operations about items
      - main_screen_dialogs.dart
    </br> #Class to open the application and make general settings
- main.dart


<h3> Design Patterns </h3>

  <ul>
  <li> <b> Singleton:</b> The services and controllers in the application are used in a singleton structure. It is invoked and used by dependency injection while calling these objects in other places where an object is produced. For example, the ShopController was produced at first, and the same object was taken and used again by dependency injection in different places. </li>
  </ul>
  
<h3> Application FlowChart </h3>

  <img src = "https://github.com/maliksenpai/flutter_e_commerce/blob/master/github_images/flowchart.png?raw=true"/>

  
  <h2> Firebase </h2>
  
  <p>
    Firebase Realtime Database is used for the database of the application. This database works like a web socket and the data is updated live. The data is stored in a NoSql structure, ie plain json, so there is no table layout.
  <br>
    Transactions made in the application are also stored for offline situations, and with the query logic, if there is no connection at the time of the transaction, that transaction is suspended and operations are continued when the connection is received. This reduces the burden on the developer, especially since it works automatically.
  <br>
    The database layout used in the application is as follows:
      
    - items
         - id
            -addedTime
            -id
            -itemDesc
            -itemName
            -price
            -shopItemCategory
  
  </p>
