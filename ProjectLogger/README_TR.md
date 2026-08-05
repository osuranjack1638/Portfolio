# Project Logger
Project Logger, Roblox üzerinde fonksiyonları takip eden ve hata ayıklama/debugging konusunda yardımcı olan bir sistem.

---

## Neden Project Logger?
Çünkü debugging, yani hata ayıklama, yanlış yapıldığında çok zor olabiliyor. Project Logger bu sorunu çözerek debug işlemini çok kolaylıştırıyor.

---

## Takip Edilebilen Objeler
- function

## Takip Edilen Değerler
- Kullanım miktarı
- Takip edilen objenin çalışması en son kaç milisaniye(ms) sürdü
- Başarısız çalıştırmalar
- Başarılı çalışma oranı
- En hızlı, en yavaş, toplam ve ortalama çalışma süreleri

---

## Nasıl Kurulur?
1. **ReplicatedStorage** içerisinde bir `ModuleScript` yaratın ve ismini `ProjectLogger` olarak değiştirin.
2. **ProjectLogger** içerisinde bir `ModuleScript` yaratın ve ismini `Config` olarak değiştirin.
3. Modüllerin kodlarını yapıştırın.
4. İstediğiniz şeyi debuglamak için kullanın!
