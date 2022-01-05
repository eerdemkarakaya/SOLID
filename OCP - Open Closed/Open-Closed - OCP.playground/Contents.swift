import UIKit

/**
 # Open-Closed Prensibi - OCP
 Yapılan proje geliştirmeye açık fakat değişime kapalı olmalıdır. Eğer biz projede benzer aynı işe ait bir ekleme için birden fazla yerde güncelleme yapıyorsak Open-Closed prensibine uymuyoruz demektir.
 
 # Notes: #
 1. Aşağıda yanlış kullanımı ve doğru kullanımına ait örnek bulabilirsiniz.
 
 # YANLIŞ KULLANIM
 - LogType enum ile loglama servislerini belirttik.
 - Log sınıfındaki send metodu ile type alarak o type'a ait log servisini çalıştırdık.
 - Buradaki sorun ileride eklenecek yeni loglama servisleri olduğunda projede hem enum'a müdahale etmemiz gerekecek, hemde Log sınıfındaki send metodunu güncellememiz gerekecektir.
 - Bu OCP 'ye göre tamamen yanlış bir kullanımdır. Çünkü bu işlemin daha anlaşılır, daha kolay ve projeyi daha az değiştirebileceğimiz yolu mevcuttur.
 
 # YAPILACAK İŞLEM
 - Loglama sınıfına ortak ait sorumluluklar için protocol yazıyoruz.
 - Her loglama için yeni birer sınıf yazıyoruz. (Az önceki protocolden inheritance alan)
 - LogManager sınıfını Dependency Injection ile Log protocolonü alacak şekilde yazıyoruz ve kullanacağımız sorumlulukları ekliyoruz.
 - Daha sonrasında tek yapmamız gereken hangi loglama servisini kullanacaksak, o sınıfı yaratıp dependency injection olarak sınıfa veriyoruz ve sınıf içerisindeki istediğimiz metodu kullanıyoruz.
 
 # DOĞRU KULLANIM
 - Gelecekte oluşturacağımız her Loglamaya ait yeni sınıf yazıp, LogManager'a dependency olarak verip, istediğimiz sorumluluğu kullanabiliriz.
 - Bu sayede sadece yeni bir inheritance alan Loglama sınıfı yaratarak projede yarattığımız sınıf haricinde hiçbir değişiklik yapmamıza gerek kalmıyor.
 */

// # YANLIŞ KULLANIM
enum LogType {
    case firebase, aws, x
}

class Log {
    func send(_ type: LogType) {
        switch type {
        case .firebase:
            print("Log sended with Firebase.")
            
        case .aws:
            print("Log sended with aws.")
            
        case .x: print("Log sended with x.")
        }
    }
}






// # DOĞRU KULLANIM
protocol Logger: AnyObject {
    func send()
}
class FirebaseLog: Logger {
    func send() {
        print("Log sended with Firebase.")
    }
}
class AWSLog: Logger {
    func send() {
        print("Log sended with AWS.")
    }
}

class LogManager {
    private var logger: Logger
    
    init(_ logger: Logger) {
        self.logger = logger
    }
    func send() {
        logger.send()
    }
}

let firebaseLogger = FirebaseLog()
var logger = LogManager(firebaseLogger)
logger.send()

let awsLogger = AWSLog()
logger = LogManager(awsLogger)
logger.send()

// Yeni bir Loglama servisi eklenmesi gerektiğinde artık sadece yeni Log sınıfını eklemek ve o sınıfa Logger'dan interitance vermemiz yeterli olacaktır. Bu sayede projede başka yerlere müdahale etmeden yeni bir loglama sistemi daha sisteme dahil olur.

// ÖRNEK:
class XLog: Logger {
    func send() {
        print("Log sended with X")
    }
}

let xLogger = XLog()
logger = LogManager(xLogger)
logger.send()
