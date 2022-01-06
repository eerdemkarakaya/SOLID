# Dependency Inversion Prensibi - DIP
Sınıflar arası ilişkileri ve bağımlılığı olabildiğince azaltmayı sağlar ve sınıfın modüler yapı olmasını sağlar. Bu modülerliği protocoller sağlar.

## Notes:
1. Aşağıda yanlış kullanımı ve doğru kullanımına ait örnek bulabilirsiniz.

## YANLIŞ KULLANIM
- Project sınıfımızın içerisinde direk olarak geliştirici(FE, BE) sınıflarını oluşturduk.
- Project sınıfının içerisinde geliştiricilerimizi tanımlayarak fazlasıyla bağımlı halde kullanıyor olduk.

```swift
class FrontendDeveloper {
    init() { }
    func developFrontend() { print("Developing Frontend.") }
}

class BackendDeveloper {
    init() { }
    func developBackend() { print("Developing Backend.") }
}

class Project {
    private var backendDev = BackendDeveloper()
    private var frontendDev = FrontendDeveloper()

    init() { }
    func startDeveloping() {
        backendDev.developBackend()
        frontendDev.developFrontend()
    }
}

Project().startDeveloping()
```

## YAPILACAK İŞLEM
- Geliştiricilerimizin ortak özelliklerini protocol olarak oluşturuyoruz.

- Project sınıfına geliştiricilerimizi oluşturduğumuz protocol ile Dependency Injection olarak veriyoruz.

- Protocol aracılığıyla verdiğimiz için Project sınıfının bağımlılığını yanlış kullanıma göre kaldırmış olduk ve modüler bir yapı sağladık.

## DOĞRU KULLANIM

```swift
protocol Developer {
    func develop()
}

class FrontendDeveloper: Developer {
    init() { }
    func develop() { developFrontend() }
    func developFrontend() { print("Developing Frontend.") }
}

class BackendDeveloper: Developer {
    init() { }
    func develop() { developBackend() }
    func developBackend() { print("Developing Backend.") }
}

class Project {
    private var developers: [Developer]

    init(_ developers: [Developer]) {
        self.developers = developers
    }
    
    func startDeveloping() {
        developers.forEach({ $0.develop() })
    }
}

let developers: [Developer] = [BackendDeveloper(), FrontendDeveloper()]
Project(developers).startDeveloping()
```
