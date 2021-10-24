# flutter_e_commerce

Uygulamanın asıl amacı e-ticaret ürünlerinin girebileceği, listelenebileceği, sıralanabilmesidir. Uygulama içerisinde eşyanın ismini, açıklamasını, fiyatını ve kategorisini seçip onu veri tabanına kaydediyoruz. Uyguluma flutter ile yapılmıştır ve back-end için firebase kullanılmıştır. Firebase realtime database kullanılmıştır veri tabanı için. 


<h2> Flutter Kullanımı </h2>

<h3> Architecture Design Pattern </h3>
<p>
  Flutter için state yönetimi ve ana işlemlerin yönetilmesi için Getx kütüphanesi kullanılmıştır. Bu kütüphane içerisinde yönetim view-controller-service şeklinde ilerlemektedir. Basitçe işlemler şu şekildedir:
  
  <ul>
    <li> Kullanıcı UI üzerinden yapmak istediğine karar verir ve istediği yere tıklar ve işlemler gerçekleşir</li>
    <li> Kullanıcının yaptığı işlem controller kısmına gider ve mantık işlemleri yapılır ve bu mantık işlemler içerisinde veri gerekiyor ise service yardımıyla veriyi alır</li>
    <li> Service tarafında veriler database sorgularıyla veya api işlemleri ile yapılır. Bu verileri controller kısmına gönderir</li>
    <li> Controller serviceden gelen verilere göre tekrar mantık işlemlerini yapar ve verilerini günceller</li>
    <li> Controller tarafından değişen verileri göre View UI güncellenir</li>
  </ul> 
</p>

<h3> Dosya Yapısı </h3>
 
  - /app  
    - /get
          </br> #Controllerların tanımlandığını ve hazırlandığı class
        - initial_bindings.dart
          </br> #Eşyaların listelenmesini, eklenmesini, güncellenmesini ve silinmesini kontrol eden controller
        - shop_get.dart
    - /service
        </br> #Bu servis yardımı ile firebase işlemlerini yapabiliyoruz.
      - firebase_service.dart
    - /model
        </br> #Listelenen ve kullanılan eşyaların tutulduğu model yapısı.
      - shop_item.dart
        </br> #Eşyaların kategorisini tutmak için kullanılan Enum
      - shop_item_category.dart
    - /view
        </br> #Eşyaların listelendiği, filtrelenebildiği veya sıralanabildiği ve eşyaların eklendiği ana sayfa
      - main_screen.dart
        </br> #Ana sayfa içerisinde tıklanılan eşyanın detay sayfası, burada eşya bilgileri detaylı bir şekilde görülebilir ve eşya düzenlenebilir ve silinebilir
      - shop_item_detail.dart
      </br> #Farklı yerlerde kullanılabilecek widgetlerin tekrar kullanılabilir bir şekilde listelendiği dizin
  - /widget
        </br> #Eşyalar hakkında yapılan dialog veya bottom sheet işlemlerinin tekrar kullanılabilir bir şekilde veren class
      - main_screen_dialogs.dart
    </br> #Uygulamanın açılmasını ve genel ayarların yapıldığı class
- main.dart 
  

<h3> Design Patternler </h3>

  <ul>
  <li> <b> Singleton:</b> Uygulama içerisindeki service ve controllerlar singleton bir yapıda kullanılmıştır. Bir objenin üretildiği ve diğer yerlerde bu objeler çağrılırken dependency injection yapılarak çağrılıp kullanılmıştır. Örnek olarak ShopController ilk başta üretilmiştir ve farklı yerlerde dependency injection yapılarak tekrar aynı obje alınmış ve kullanılmıştır. </li>
  </ul>
  
<h3> Uygulama FlowChartı </h3>

  <img src = "https://github.com/maliksenpai/flutter_e_commerce/blob/master/github_images/flowchart.png?raw=true"/>

  
  <h2> Firebase </h2>
  
  <p>
    Uygulamanın veritabanı için Firebase Realtime Database kullanışmıştır. Bu veri tabanı web socket'e benzer mantıkta çalışır ve veriler canlı olarak güncellenir. Veriler NoSql bir yapıda yani düz json şeklinde saklanır, bu yüzden bir tablo düzeni yoktur.
  <br>
    Uygulama içerisinde yapılan işlemler çevrimdışı durumlar için de saklanır  ve query mantığı ile eğer işlem anında bağlantı yoksa o işlem bekletilir ve bağlantı geldiğinde işlemler yapılmaya devam edilir. Bu özellikle otomatik olarak çalıştığı için ise geliştiricinin yükünü azaltır.
  <br>
    Uygulama içerisinde kullanılan veritabanı düzeni şu şekildedir:
      
    - items
         - id
            -addedTime
            -id
            -itemDesc
            -itemName
            -price
            -shopItemCategory
  
  </p>
