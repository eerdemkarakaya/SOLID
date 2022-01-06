import UIKit


/**
 # Interface Segregation Prensibi - ISP
 Protocoller kullanamayacakları şeyleri barındırmamalılardır ve her interface amacına yönelik şeyler barındırmalıdır. Yani aslında SRP benzeri bir prensiptir.
 
 # Notes: #
 1. Aşağıda yanlış kullanımı ve doğru kullanımına ait örnek bulabilirsiniz.
 
 # YANLIŞ KULLANIM
 - Worker Protocol tanımlamasında robot ve insan özellikleri birlikte tanımlanmıştır.
 - Yani insanlar robot özelliklerini yapamaz, robotlar insan özelliklerini yapamaz.
 
 # YAPILACAK İŞLEM
 - Ortak özellikleri için ortak bir protocol, türlere göre özellikler için ise türe özel protocoller kullanmalıyız.
 
 # DOĞRU KULLANIM
 - Protocolleri ortak özelliklerine göre ve türe göre ayırdık.
 */

// MARK: - YANLIŞ KULLANIMI
protocol Worker: AnyObject {
    func startWork()
    func continueWork()
    func stopWork()
    func teaBreak()
    func lunch()
    func oilCheck()
    func batteryCharge()
}


class HumanWorker: Worker {
// Ortak Metotlar
    func startWork() { }
    func continueWork() { }
    func stopWork() { }

// İnsana Ait Metotlar
    func teaBreak() { }
    func lunch() { }

// Robota Ait Metotlar => HumanWorker İçin Gereksiz
    func oilCheck() { }
    func batteryCharge() { }
}

class RobotWorker: Worker {
// Ortak Metotlar
    func startWork() { }
    func continueWork() { }
    func stopWork() { }

// İnsana Ait Metotlar => RobotWorker İçin Gereksiz
    func teaBreak() { }
    func lunch() { }

// Robota Ait Metotlar
    func oilCheck() { }
    func batteryCharge() { }
}




// MARK: - DOĞRU KULLANIMI
protocol Workerr: AnyObject {
    func startWork()
    func continueWork()
    func stopWork()
}

protocol Human: AnyObject {
    func teaBreak()
    func lunch()
}

protocol Robot: AnyObject {
    func oilCheck()
    func batteryCharge()
}


class HumanWorkerr: Workerr, Human {
// Ortak Metotlar
    func startWork() { }
    func continueWork() { }
    func stopWork() { }

// İnsana Ait Metotlar
    func teaBreak() { }
    func lunch() { }
}

class RobotWorkerr: Workerr, Robot {
// Ortak Metotlar
    func startWork() { }
    func continueWork() { }
    func stopWork() { }
    
// Robota Ait Metotlar
    func oilCheck() { }
    func batteryCharge() { }
}
