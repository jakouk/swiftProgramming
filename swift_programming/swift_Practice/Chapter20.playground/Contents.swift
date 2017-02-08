//: Playground - noun: a place where people can play

import UIKit

/// Chapter20. 프로토콜

/*
    프로토콜이란 
 
    프로토콜은 특정 역할을 수행하기 위한 메서드, 프로퍼티, 기타 요구사항등의 청사진을 정의합니다. 구조체, 클래스, 열거형은
    프로토콜을 채택해서 특정 기능을 수행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있습니다. 어떤 프로토콜의 요구사항을
    모두 따르는 타입은 그 '프로토콜을 준수한다' 고 표현합니다. 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 
    제시하는 청사진의 기능을 모두 구현해야 합니다. 즉 프로토콜은 정의를 하고 제시 할 뿐이지 스스로 기능을 구현하지는 
    않습니다.
 
    프로토콜은 구조체, 클래스, 열거형의 모양과 비슷하게 정의할 수 있으며 protocol 키워드를 사용합니다.
    
    protocol 프로토콜 이름 {
        프로토콜 정의
    }
 
    구조체, 클래스, 열거형 등에서 프로토콜을 채택하려면 타입 이름 뒤에 콜론 (:)을 부여준 후 채택할 프로토콜 이름을 
    쉼표(.)로 구분하여 명시해줍니다.
 */



/// 20-1 타입의 프로토콜 채택

/*
struct SomeStruct : AProtocol, AnotherProcotol {
    // 구조체 정의
}

class SomeClass : AProtocol, AnotherProtocol {
    // 클래스 정의
}

enum SomeEnum : AProtocol, ANotherProtocol {
    // 열거형 정의
}
*/



/// 20-2 superClass를 상속받는 클래스의 프로토콜 채택

/*
class SomeClass : SuperClass, AProtocol, AnotherProtocol {
    // 클래스
}
*/



/*
    프로토콜 요구사항 
 
    프로토콜은 타입이 특정 기능을 수행하기 위해 필요한 기능을 요구합니다. 프로토콜이 자신을 채택한 타입에 요구하는 사항은 
    프로퍼티나 메서드 같은 기능입니다.
 */



/*
    프로퍼티 요구
 
    프로토콜은 자신을 채택한 타입이 어떤 프로퍼티로 구현해야 하는지 요구할수 있습니다. 그렇지만 프로토콜은 그 프로퍼티의 종류 
    ( 연산 프로퍼티인지, 저장프로퍼티인지 등)는 따로 신경 쓰지 않습니다. 프로토콜을 채택한 타입은 프로토콜이 요구하는 
    프로퍼티의 이름과 타입만 맞도록 구현해주면 됩니다. 다만 프로퍼티를 읽기 전용으로 할지 혹은 읽고 쓰기가 모두 가능하게 할지는
    프로토콜이 정해야 합니다.
 
    만약 프로토콜이 읽고 쓰기가 가능한 프로퍼티를 요구한다면 읽기만 가능한 상수 저장 프로퍼티 또는 읽기전용 연산 프로퍼티를
    구현할 수 없습니다. 만약 프로토콜이 읽기 가능한 프로퍼티를 요구한다면 타입에 프로퍼티를 구현할 떄 상수 저장 프로퍼티나 
    읽기 전용 프로퍼티를 포함해서 어떤 식으로든 프로퍼티를 구현할 수 있습니다. 쓰기만 가능한 프로퍼티는 없으니 타입에
    구현해주는 프로퍼티는 무엇이 되어도 상관이 없습니다. 
 
    프로토콜의 프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의됩니다. 읽기와 쓰기가 모두 가능한 프로퍼티는
    프로퍼티의 정의 뒤에 {get set}이라고 명시하며, 읽기 전용 프로퍼티는 프로퍼티의 정의 뒤에 {get}이라고 명시해줍니다.
 */



/// 20-3 프로퍼티의 요구

protocol SomeProtocol {
    var settableProperty: String { get set }
    var notNeedToBeSettableProperty: String { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }    // 타입 프로퍼티
    static var anotherTypeProperty: Int { get }
}



/// 20-4 Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스

/*
protocol Sendable {
    var from: String { get }
    var to: String { get }
}

class Message: Sendable {
    
    var sender: String
    var from: String {
        return self.sender
    }
    
    var to: String
    
    init(sender: String, receiver: String) {
        self.sender = sender
        self.to = receiver
    }
}

class Mail: Sendable {
    
    var from: String
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}
*/


/*
    메서드 요구
 */



/// 20-5 Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스

// 무언가를 수신받을 수 있는 기능
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

// 무언가를 발시할 수 있는 기능

protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance( _ instance: Any) -> Bool
}

class Message: Sendable, Receiveable {
    
    // 발신은 발신 간ㅇ한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var from: Sendable {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var to : Receiveable?
    
    // 메세지를 발신합니다.
    
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    
    // 메세지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("Message received \(data) fromt \(from)")
    }
    
    // class 메서드이므로 상속이 가능합니다.
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신 발신이 가능한 Mail Class 
class Mail: Sendable, Receiveable {
    
    var from: Sendable {
        return self
    }
    
    var to: Receiveable?
    
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Mail received \(data) from \(from)")
    }
    
    // static 메서드이므로 상속이 불가능합니다.
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// 두 Mail 인스턴스를 생성합니다.
let myMail: Mail = Mail()
let yourmail: Mail = Mail()

myMail.send(data: "Hi")

// Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있습니다.
myMail.to = yourmail
myMail.send(data: "Hi")
myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않습니다.
Message.isSendableInstance("Hello") // fasle

// Mail과 Message는 Sendable 프로토콜을 준수합니다.
Message.isSendableInstance(myPhoneMessage)  // true

// yourPhoneMessage는 to 프로퍼티가 셋팅되지 않아서 보낼 수 없는 상태입니다.
Message.isSendableInstance(yourPhoneMessage)
Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)



/*
    가변 메서드 요구
 */



/// 20-6 Resettable 프로토콜의 가변 메서드 요구

/*
protocol Resettable {
    mutating func reset()
}

class Person: Resettable {
    var name: String?
    var age: Int?
    
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable {
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable {
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}
*/


/// 20-7 프로토콜의 이니셜라이저 요구와 구조체의 이니셜라이저 요구 구현

protocol Named {
    var name: String { get }
    
    init(name: String)
}

struct Pet: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}



/// 20-8 클래스의 이니셜라이저 요구 구현

/*
class Person: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}
*/



/// 20-9 상속 불가능한 클래스의 이니셜라이저 요구 구현

final class Person: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}



/// 20-10 상속받은 클래스의 이니셜라이저 요구 구현 및 재정의 

class School {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override init(name: String) {
        super.init(name: name)
    }
}



/// 20-11 실패 가능한 이니셜라이저 요구를 포함하는 Named 프로토콜과 Named 프로토콜을 준수하는 다양한 타입들

protocol Named1 {
    var name: String { get }
    
    init?(name: String)
}

struct Animal: Named1 {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct Pet1: Named1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person1: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class School1: Named1 {
    var name: String
    
    required init?(name: String) {
        self.name = name
    }
}



/// 20-4 프로토콜의 상속

protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func write() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}


/// 20-13 클래스 전용 프로토콜의 정의

protocol ClassOnlyProtocol: class, Readable, Writeable {
    // 추가 요구사항
}

class SomeClass1: ClassOnlyProtocol {
    func read() {}
    func write() {}
}

// 오류!! ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능합니다.
//struct SomeStruct: ClassOnlyProtocol {
//    
//}



/// 20-14 프로토콜 조합

protocol Named2{
    var name: String { get }
}

protocol Aged2 {
    var age: Int { get }
}

struct Person2: Named2, Aged2 {
    var name: String
    var age: Int
}

struct Car: Named2, Aged2 {
    var name: String
    var age: Int
}

func celebrateBirthday(to celebrate: Named2 & Aged2) {
    print("Happy birthday \(celebrate.name) !! Now you are \(celebrate.age)")
}

let yagom: Person2 = Person2(name: "yagom", age: 99)
celebrateBirthday(to: yagom)

let myCar: Car = Car(name: "Boong Boong", age: 12)
celebrateBirthday(to: myCar)



// 20-15 프로토콜 캐스팅

print(yagom is Named2)   // true
print(yagom is Aged2)    // true

print(myCar is Named2)   // true
print(myCar is Aged2)   // 원래는 false 이지만 오류때문에 true로 만들어 놓음

if let castedInstance: Named2 = yagom as? Named2 {
    print("\(castedInstance) is Named2")
    // Person2 is Named
}

if let castedInstance: Aged2 = yagom as? Aged2 {
    print("\(castedInstance) is Aged2")
    // Person is Age2
}

if let castedInstance: Named2 = myCar as? Named2 {
    print("\(castedInstance) is Named2")
}

if let castedInstance: Aged2 = myCar as? Aged2 {
    print("\(castedInstance) is Aged2")
}



/*
    프로토콜의 선택적 요구
 
    프로토콜의 요구사항 중 일부 요구사항을 선택적 요구사항으로 지정할 수 있습니다. 다만 먼저 고려해야 할 사항이 있습니다.
    선택적 요구사항을 정의하고 싶은 프로토콜은 @objc 속성을 해당 프로토콜의 Objective-C 코드에서 사용 하수 있도록
    만드는 역할을 합니다. 그렇지만 해당 프로토콜을 Objective-c 코드와 공유하고 싶지 않더라고, 혹은 프로젝트를 
    objective-C 코드와 공유하고 있지 않더라고 @objc 속성이 부여되어야만 석택정 요구사항을 정의할수 있습니다. 여기서
    더 생각해보야할 할 것은 @objc 속성이 부여되는 프로토콜은 objective-c 클래스를 상속받은 클래스에서만 채택할수 
    있다는 것입니다. 즉 열거형이나 구조체 등에서는 @objc 속성이 부여된 프로토콜은 아예 채택될수 없습니다.
 
    기본적으로 선택적 요구는 옵셔널 타입입니다.
 */



/// 20-16 프로토콜의 선택적 요구

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

// 걷기만 할수 있는 호랑이 

class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiger walks")
    }
}

class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    func fly() {
         print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()    // Tiger walks

bird.walk() // Bird walks
bird.fly()  // Bird flys

var movableInstance: Moveable = tiger
movableInstance.fly?()  // 응답 없음

movableInstance = bird
movableInstance.fly?()  // Bird flys



/// 20-17 프로토콜 타입 변수

var someNamed: Named1 = Animal(name: "Animal")
someNamed = Pet1(name: "Pet")
//someNamed = Person1(name: "Person")
someNamed = School1(name: "School")!

/*
    프로토콜은 프로토콜 이름을 통해 자기 스스로 인스턴스를 생성하고 초기화할 수는 없습니다. 그렇지만 프로토콜 변수나
    상수를 생성하여 특정 프로토콜을 준수하는 타입의 인스턴스를 할당할 수는 있습니다.
 */



/*
    20.8 위임을 위한 프로토콜
 
    위임은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴입니다. 책무를 위임하기 위해
    정의된 프로토콜을 준수하는 타입은 자신에게 위임 될 일정 책무를 수행할 수 있다는 것을 보장합니다. 그렇지 때문에 다른 
    인스턴스에게 자신이 수행해야 할 일을 믿고 맡길 수 있습니다. 위임은 사용자의 특정 행동에 반응하기 위해 사용되기도 하며,
    비동기적인 처리에도 많이 사용됩니다.
 
    위임패턴은 애플의 프레인워크에서 사용되는 주요한 패턴 중 하나입니다. 언어 자체로의 기능이 아닌 하나의 디자인패턴이지만
    애플의 프레임워크에서 중요하게 사용되는 만큼, 개념을 알아두면 후에 애플 플랫폼의 애플리케이션을 제작할 때 도움이 됩니다.
    애플의 프레임워크에 사용되는 위임 패턴을 위해 다양한 프로토콜이 '0000Delegate' 라는 식의 이름으로 정의되어 있습니다.
    예를 들어 UITableView 타입의 인스턴스가 수행해야 하는 일을 위임 받아 처리하는 인스턴스는 UITableViewDelegate 
    프로토콜을 준수하면 됩니다. 위임받은 인스턴스 즉 UITableViewDelegate 프로토콜을 준수하는 인스턴스는 UITableVIew의 
    인스턴스가 수행해야 하는 일을 대신 처리해줄 수 있습니다. 
 */







