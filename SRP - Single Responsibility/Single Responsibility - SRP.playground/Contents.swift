import UIKit

/**
 # Single Responsibility Prensibi - SRP
 Her class/methot 'a ait tek bir sorumluluk olmalıdır. Birden fazla soruna çözüm buluyorsa orada Single Responsibility Prensibi uygulanmıyordur.
 
 # Notes: #
 1. Aşağıda yanlış kullanımı ve doğru kullanımına ait örnek bulabilirsiniz.
 
 # YANLIŞ KULLANIM
 - Employee sınıfında hem employee sorumlulukları var, hemde loglama ile alakalı sorumluluklar var. Bu yüzden bu kullanım hatalı bir kullanımdır. Her sorumluluğun kendisine ait bir sınıfı olmalıdır.
 
 # YAPILACAK İŞLEM
 - Log ile alakalı işlemleri silip, Log sınıfına taşıyoruz. Artık Loglama ile işlemleri tüm proje boyunca log sınıfından kullanacağız.
 - İleride Log ile ilgili bir değişiklik yapmamız gerektiğinde sadece Log sınıfında değişiklik yapmamız yeterli olacaktır.
 
 # DOĞRU KULLANIM
 - Factory ve Log sınıfını birbirinden ayırarak her sınıfın kendisine ait sorumluluklarını belirttik. Bu sayede SRP kuralına uygun bir kod yazmış olduk.
 */


struct EmployeeModel {
    var name: String
    var surname: String
    var jobTitle: String
}

class EmployeeManager {
    func addEmployee(_ employee: EmployeeModel) {
        print("\(employee.name) Employee added for \(employee.jobTitle) jobTitle.")
        LogManager().sendLog("Employee Add")
    }
    func removeEmployee(_ employee: EmployeeModel) {
        print("\(employee.name) Employee removed from \(employee.jobTitle) jobTitle.")
        LogManager().sendLog("Employee Remove")
    }
    func updateEmployee(_ employee: EmployeeModel) {
        print("\(employee.name) Employee updated from \(employee.jobTitle) jobTitle.")
        LogManager().sendLog("Employee Update")
    }
    
// YANLIŞ KULLANIM => Loglama kodlarını sildik ve Log sınıfına taşıdık.
//    func sendLog(_ logName: String) {
//        print("\(logName) logged.")
//    }
//    func getLastLogs(_ count: Int) {
//        print("Last \(count) count is => ....")
//    }
//    func removeLog(withName name: String) {
//        print("\(name) Log removed.")
//    }
}

class LogManager {
    func sendLog(_ logName: String) {
        print("\(logName) logged.")
    }
    func getLastLogs(_ count: Int) {
        print("Last \(count) count is => ....")
    }
    func removeLog(withName name: String) {
        print("\(name) Log removed.")
    }
}

let employeeManager = EmployeeManager()
employeeManager.addEmployee(EmployeeModel(name: "Erdem", surname: "Karakaya", jobTitle: "iOS DEVELOPER"))
employeeManager.updateEmployee(EmployeeModel(name: "Ülkü", surname: "Karakaya", jobTitle: "FULL STACK DEVELOPER"))
employeeManager.removeEmployee(EmployeeModel(name: "Deneme", surname: "Kullanıcısı", jobTitle: "Deneme"))

