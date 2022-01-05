import UIKit


/**
 # Liskov Substitution Prensibi - LSP
 Protocoldeki tüm özellikleri kalıtım verdiği class kullanmalıdır. Kullanmadığı hiçbir özellik olmamalıdır.
 
 # Notes: #
 1. Aşağıda yanlış kullanımı ve doğru kullanımına ait örnek bulabilirsiniz.
 
 # YANLIŞ KULLANIM
 - Ucak Protocolünde 3 adet metot vardır. Bunlar hem savaş uçaklarına hemde casus uçaklarında kalıtım vermektedir.
 - Bu kalıtım verilen her metot ucaklara göre farklılık göstermesi gerekmektedir. Çünkü casus uçaklarında ateş etme metodu bulunmamaktadır.
 - Bu yüzden bu metot sınıfa implement edilip kullanılmayacağı için LSP'ye uygun kullanım olmamıştır.
 
 # YAPILACAK İŞLEM
 - Her özelliği protocollere bölerek gerekli olan özelliklerden kalıtım verilir.
 
 # DOĞRU KULLANIM
 - AteşEtme, DepoDoldurma, KesifYapma gibi özellikleri ayrı protocollere bölerek her uçağa gerekli olan kalıtımlar verilmesi gerekiyor.
 */

// MARK: - YANLIŞ KULLANIMI
protocol Ucak: AnyObject {
    func atesEt()
    func depoDoldur()
    func kesifYap()
}

// SAVAŞ UÇAĞI 1
class UcakA: Ucak {
    func atesEt() {
        print("Uçak A ateş etti.")
    }
    func depoDoldur() {
        print("Uçak A deposunu doldurdu.")
    }
    func kesifYap() {
        print("Uçak A keşif yaptı.")
    }
}
// SAVAŞ UÇAĞI 2
class UcakB: Ucak {
    func atesEt() {
        print("Uçak B ateş etti.")
    }
    func depoDoldur() {
        print("Uçak B deposunu doldurdu.")
    }
    func kesifYap() {
        print("Uçak B keşif yaptı.")
    }
}
// CASUS UÇAĞI 1 ==> HATA: Casus uçağında ateş et metoduna ait özellikler boş olacaktır. Kullanılmayacak metotu kalıtım olarak almış olduk.
class UcakC: Ucak {
    func atesEt() {
        fatalError("Ucak C ateş etme mekanizmasına sahip değildir.")
    }
    func depoDoldur() {
        print("Uçak A deposunu doldurdu.")
    }
    func kesifYap() {
        print("Uçak A keşif yaptı.")
    }
}

let ucak = UcakA()
ucak.atesEt()
ucak.depoDoldur()
ucak.kesifYap()

let ucak2 = UcakC()
// ucak2.atesEt() -> HATA: Casus uçağında bu özellik olmadığı için gereksiz kullanım olacaktır.
ucak2.depoDoldur()
ucak2.kesifYap()



// MARK: - DOĞRU KULLANIMI
protocol AtesEdilebilir: AnyObject {
    func atesEt()
}
protocol DepoDoldurabilir: AnyObject {
    func depoDoldur()
}
protocol KesifYapabilir: AnyObject {
    func kesifYap()
}

// SAVAŞ UÇAĞI 3
class UcakE: AtesEdilebilir, DepoDoldurabilir, KesifYapabilir {
    func atesEt() {
        print("Uçak E ateş etti.")
    }
    func depoDoldur() {
        print("Uçak E deposunu doldurdu.")
    }
    func kesifYap() {
        print("Uçak E keşif yaptı.")
    }
}
// CASUS UÇAĞI 2
class UcakU: DepoDoldurabilir, KesifYapabilir {
    func depoDoldur() {
        print("Uçak E deposunu doldurdu.")
    }
    func kesifYap() {
        print("Uçak E keşif yaptı.")
    }
}

var ucak3 = UcakU()
ucak3.depoDoldur()
ucak3.kesifYap()
