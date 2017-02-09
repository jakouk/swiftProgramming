//: Playground - noun: a place where people can play

import UIKit

///Chapter 23. 프로토콜 지향 프로그래밍 

/*
    프로토콜 초기구현 
    익스텐션은 기존 타입의 기능을 확장하며, 프로토콜은 프로토콜을 채택한 타입이 원하는 기능을 강제로 구현한다는 점을 우리는 
    알고 있습니다. 그런데 특정 프로토콜을 정의하고 여러 타입에서 이 프로토콜을 준수하게 만들어 타입마나 똑같은 메서드, 
    똑같은 프로퍼티, 똑같은 서브스크립트 등을 구현해야 한다면...? 얼마나 많은 코드를 중복 사용해야 하며 또 유지보수는 얼마나
    힘들어질지 생각만 해도 머리가 아플겁니다. 이떄 필요한 게 바르 익스텐션과 프로토콜의 결합입니다.
 
 */



/// 23-1 익스텐션을 통한 프로토콜읠 실제 구현

protocol Receiveable {
    func received(data: Any, from: Sendable)
}

extension Receiveable {
    
    // 메세지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("\(self) received \(data) from \(from)")
    }
}

// 무언가를 반실할 수 있는 기능

protocol Sendable {
    var from: Sendable { get }
    var to : Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var from: Sendable {
        return self
    }
    
    // 메세지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Message Class
class Message: Sendable, Receiveable {
    var to: Receiveable?
}

// 수신, 발신이 가능한 Mail Class 
class Mail: Sendable, Receiveable {
    var to: Receiveable?
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받은 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")  // Message has no receiver

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")  // Message received Hello from Message

// Mail 인스턴스를 두 개 생성합니다.

let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi") // Mail has no receiver

// Message와 Mail 모두 Senderable 과 Receiveable 프로토콜을 준수하므로 서로 주고 받을수 있습니다.
myMail.to = yourMail
myMail.send(data: "Hi") // Mail received Hi from Mail

myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않습니다.
Message.isSendableInstance("Hello") //false

// Message와 Mail은 Sendable 프로토콜을 준수합니다.
Message.isSendableInstance(myPhoneMessage)
//yourPhoneMessage는 to 프로퍼티가 셋팅 되지 않아서 보낵 수 없는 상태입니다. 
Message.isSendableInstance(yourPhoneMessage)
Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)

/*
    그 외의 기능은 이미 각 프로토콜의 익스텐션에서 구현되어 있습니다. 프로토콜을 정의할 때는 그 프토콜을 채택한
    타입에서 구현해주어야 하는 프로토콜의 요구사항을 구현할 수 없습니다. 단지 요구사항을 정의만 할 수 있을 뿐입니다.
    그러나 프로토콜의 익스텐션에는 프로토콜이 요구하는 기능을 실질적으로 구현해줄 수 있습니다. 다만 익스텐션에는 저장 프로퍼티를
    구현할 수 없으므로 저장 프로퍼티는 각각의 타입에서 직접 구현해야 합니다. 이렇게 프로토콜과 익스텐션을 결합하면 코드의 
    재사용성이 월등히 증가합니다.
 
    이처럼 프로토콜의 요구사항을 익스텐션을 통해 구현하는 것을 프로토콜 초기구현이라고 합니다.
    그런데 만약 프로토콜의 신스테션에서 구현한 기능을 사용하지 않고 타입의 특성에 따라 조그변해서 구현하고 싶다면 재정의하면 
    됩니다.
 */



/// 23-2 익스텐션을 통해 구현된 메서드 재정의 

class Mail1: Sendable, Receiveable {
    var to: Receiveable?
    
    func send(data: Any) {
        print("Mail의 send 메서드는 재정의 되었습니다.")
    }
}

let mailInstance: Mail1 = Mail1()
mailInstance.send(data: "Hello")    // Mail의 send 메서드는 재정의되었습니다.



/// 23-3 제네릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성

protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable where Self: Container {
    func printSelf() {
        print(items)
    }
}

protocol Container: SelfPrintable {
    associatedtype ItemType
    
    var items: [ItemType] { get set }
    var count: Int { get }
    
    mutating func append(item: ItemType)
    
    subscript(i: Int) -> ItemType { get }
}

extension Container {
    
    mutating func append(item: ItemType) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

protocol Popable: Container {
    mutating func pop() -> ItemType?
    mutating func push( _ item: ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    
    mutating func push( _ item: ItemType) {
        self.append(item: item)
    }
}

protocol Insertable: Container {
    mutating func delete() -> ItemType?
    mutating func insert(_ item: ItemType)
}

extension Insertable {
    mutating func delete() -> ItemType? {
        return items.removeLast()
    }
    
    mutating func insert(_ item: ItemType) {
        self.append(item: item)
    }
}

struct Stack<Element>: Popable {
    var items: [Element] = [Element]()
    
    /// 23-6 구조체의 맵 메서드
    /// Stack 구조체 구현부
    
    func map<T>(transform: (Element) -> T) -> Stack<T> {
        var transformedStack: Stack<T> = Stack<T>()
        
        for item in items {
            transformedStack.items.append(transform(item))
        }
        
        return transformedStack
    }
    
    /// 23-7 구조체의 필터 메서드
    /// Stack 구조체 구현부
    
    func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
        var filteredStack: Stack<ItemType> = Stack<ItemType>()
        
        for item in items {
            if includeElement(item) {
                filteredStack.items.append(item)
            }
        }
        return filteredStack
    }
    
    /// 23-10 Stack 구조체의 리듀스 메서드
    /// Stack 구조체 구현부
    
    func reduce<T>(_ initial: T, combine: (T, Element) -> T ) -> T {
        
        var result: T = initial
        
        for item in items {
            result = combine(result,item)
        }
        return result
    }
}

struct Queue<Element>: Insertable {
 
    var items: [Element] = [Element]()
}

var myIntStack: Stack<Int> = Stack<Int>()
var myStringStack: Stack<String> = Stack<String>()

var myIntQueue: Queue<Int> = Queue<Int>()
var myStringQueue: Queue<String> = Queue<String>()

myIntStack.push(3)
myIntStack.printSelf()  // [3]

myIntStack.push(2)
myIntStack.printSelf()  // [3, 2]

myIntStack.pop()
myIntStack.printSelf()  // [3]


myStringStack.push("A")
myStringStack.printSelf()

myStringStack.push("B")
myStringStack.printSelf()

myStringStack.pop()
myStringStack.printSelf()


myIntQueue.insert(3)
myIntQueue.printSelf()

myIntQueue.insert(2)
myIntQueue.printSelf()

myIntQueue.delete()
myIntQueue.printSelf()


myStringQueue.insert("A")
myStringQueue.printSelf()

myStringQueue.insert("B")
myStringQueue.printSelf()

myStringQueue.delete()
myStringQueue.printSelf()



/// 23-5 Array 타입의 맵 사용

let items: Array<Int> = [1,2,3,]

let mappedItem: Array<Int> = items.map { (item: Int ) -> Int in
    return item * 10
}

print(mappedItem)



/// 23-6 구조체의 맵 메서드

var myIntStack1: Stack<Int> = Stack<Int>()
myIntStack1.push(1)
myIntStack1.push(5)
myIntStack1.push(2)

myIntStack.printSelf()  // [1, 5, 2]

var mystrStack1: Stack<String> = myIntStack1.map{ "\($0)" }
mystrStack1.printSelf()



/// 23-7 Array 타압의 필터 사용

let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
    return item % 2 == 0
}

print(filteredItems)    // [2]



/// 23-8 Stack 구조체의 필터 메서드 

let filteredStack: Stack<Int> = myIntStack1.filter { (item: Int) -> Bool in
    return item < 5
}

filteredStack.printSelf()   // [1, 2]



/// 23-9 Array 타입의 리듀스 사용

let combinedItems: Int = items.reduce(0) { (result: Int, item: Int) -> Int in
    return result + item
}
print(combinedItems)    // 6


let combinedItemsDoubled : Double = items.reduce(0.0) { ( result: Double, item: Int) -> Double in
    return result + Double(item)
}
print(combinedItemsDoubled) //6.0


let combinedItemsString: String = items.reduce("") { (result: String, item: Int) -> String in
    return result + "\(item)"
}
print(combinedItemsString) // "1 2 3"



/// 23-10 Stack 구조체의 리듀스 메서드

let combinedInt: Int = myIntStack1.reduce(100) { (result: Int, item: Int) -> Int in
    return result + item
}
print(combinedInt)

let combinedDouble: Double = myIntStack1.reduce(100.0) { (result: Double, item: Int) -> Double in
    return result + Double(item)
}
print(combinedDouble)

let combinedString: String = myIntStack1.reduce("") { (result: String, item: Int) -> String in
    return result + "\(item) "
}
print(combinedString)


/// 23-11 SelfPrintable 프로토콜의 초기구현과 기본 타입의 확장

extension SelfPrintable {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable {}
extension String: SelfPrintable {}
extension Double: SelfPrintable {}

1024.printSelf()    // 1024
3.14.printSelf()    // 3.14
"hana".printSelf()  // "hana"



/*
    결국 프로토콜 지향이란 프로토콜을 통해서 전체적인 설계를 만들어 놓고 그 설계를 따라서 만든 프로터티나 함수들을 extension
    을 통해서 구현해 놓고 적절하게 사용하면서 클래스마다 다른 부분들은 override를 받아 재정의 하는등의 방법인것 같다.
 */







