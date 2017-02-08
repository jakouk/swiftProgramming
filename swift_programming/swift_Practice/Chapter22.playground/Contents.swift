//: Playground - noun: a place where people can play

import UIKit

/// Chapter22. 제네릭

/*
    제네릭
    제네릭은 스위프트의 강력한 기능 중 하나입니다. 제네릭을 사용해 코드를 구현하면 어떤 타입에도 유연하게 대응할 수 있습니다.
    또한 제네릭으로 구현한 기능과 타입은 재사용하기에도 쉽습니다. 제네릭을 사용하면 코드의 중복을 줄일 수 잇기에 깔끔하고 
    추상적인 표현이 가능합니다.
 
    스위프트 표준 라이브러리 또한 수많은 제네릭 코드로 구성되어 있습니다. 사실 우리는 지금까지 제네릭 기능을 수없이 사용하고
    있었습니다. 예를 들어 Array, Dictionay, Set 등의 타입은 모두 제네릭 컬렉션 입니다. Int 나 String 타입을 요소로
    가지는 배열을 만들거나 그 외의 어떤 타입도 배열의 요소로 가질 수 있었던 것은 모두 제네릭 덕분입니다. 딕셔너리도 세트도 
    마찬가지입니다.
 */



/// 22-1 제네릭, 프로토콜, 서브스크립트등 다양한 기능으로 구현된 Array 타입 선언부

/*
public struct Array<Element> : RandomAccessCollection, MutableCollection {
    
    public typealias Index = Int
    public typealias Iterator = IndexingIteractor<[Element]>
    
    // 중략
    
    public var startIndx: Int { get }
    public var endInex: Int { get }
    
    // 중략
    
    public subscript(index: Int) -> Element
    public subscript(bounds: Range<Int>) -> ArraySlice<Element>
    
    // 중략 
    
    // 중략
}
 */



/*
    제네릭을 사용하고자 할 때는 제네릭이 필요한 타입 또는 메서드의 이름 뒤에 부등호 기호(<>) 사이에 제니릭을 위한 티입 
    매개변수를 표시하여 제네릭을 사용할 것임을 표시합니다.
 
    제네릭을 사용하고자 하는 타입 이름 < 타입 매개변수 >
    제네릭을 사용하고자 하는 함수 이름 < 타입 매개변수 > (함수의 매개변수...)
 */



/// 5-7 전위 연산자 구현과 사용

/*
prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)    // 25
*/



/// 22-2 프로토콜과 제네릭을 사용한 전위 연산자 구현과 사용

prefix operator **

prefix func ** <T: Integer> (value: T) -> T {
    return value * value
}

let minusFive: Int = -5
let five: UInt = 5

let sqrtMinusFive: Int = **minusFive
let sqrtFive: UInt = **five

print(sqrtMinusFive)
print(sqrtFive)



/// 22-3 제네릭을 사용하지 않는 swapTwoInts(_:_:) 함수

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA: Int = a
    a = b
    b = temporaryA
}

var numberOne: Int = 5
var numberTwo: Int = 10

swapTwoInts(&numberOne, &numberTwo)

print("\(numberOne), \(numberTwo)") // 10, 5



/// 22-4 제네릭을 사용하지 않은 swapTwoStrings(_:_:)함수

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA: String = a
    a = b
    b = temporaryA
}

var stringOne: String = "A"
var stringTwo: String = "B"

swapTwoStrings(&stringOne, &stringTwo)

print("\(stringOne), \(stringTwo)") // "B, A"



/// 22-5 제네릭을 사용하지 않은 swapTwoValues(_:_:) 함수

func swapTwoValues(_ a: inout Any, _ b: inout Any) {
    let temporaryA: Any = a
    a = b
    b = temporaryA
}

var anyOne: Any = 1
var anyTwo: Any = "Two"

swapTwoValues(&anyOne, &anyTwo)

print("\(anyOne), \(anyTwo)")   // "Two" , 1

anyOne = stringOne
anyTwo = stringTwo

swapTwoValues(&anyOne, &anyTwo)

print("\(anyOne), \(anyTwo)")   // "A, B"
print("\(stringOne), \(stringTwo)") // "B, A"

// swapTwoValues(&stringOne, &stringTwo)   // 오류 - Any 외 다른 타입의 전달인자 전달 불가



/// 22-6 제네릭을 사용한 swapTwoValues(_:_) 함수

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA:T = a
    a = b
    b = temporaryA
}

swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")

swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)")

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")

// swapTwoValues(&numberOne, &stringOne)   // 오류!! - 같은 타입끼리만 교환 가능



/// 22-7 제네릭을 사용하지 않은 IntStack 구조체 타입

struct IntStack {
    var items = [Int]()
    mutating func push( _ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

var integerStack: IntStack = IntStack()

integerStack.push(3)
print(integerStack.items)

integerStack.push(2)
print(integerStack.items)

integerStack.push(3)
print(integerStack.items)

integerStack.push(5)
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)


integerStack.pop()
print(integerStack.items)



/// 22-8 제네릭을 사용한 Stack 구조체 타입

struct Stack<Element> {
    var items = [Element]()
    mutating func push( _ item : Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)

doubleStack.push(2.0)
print(doubleStack.items)

doubleStack.pop()
print(doubleStack.items)

doubleStack.pop()
print(doubleStack.items)


var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)

stringStack.push("2")
print(stringStack.items)

stringStack.pop()
print(stringStack.items)

stringStack.pop()
print(stringStack.items)


var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)

anyStack.push("2")
print(anyStack.items)

anyStack.push(3)
print(anyStack.items)

anyStack.pop()
print(anyStack.items)



/// 22-9 익스텐션을 통한 제네릭 타입의 기능 추가

extension Stack {
    var topElement: Element?{
        return self.items.last
    }
}

print(doubleStack.topElement)
print(stringStack.topElement)
print(anyStack.topElement)



/*
    타입 제약
 
    타입제약은 타입 매개변수가 가져야 할 제약사항을 지정할 수 있는 방법입니다. 예를 들어 타입 매개변수 자리에 사용될 실제 타입이
    특정 클래스를 상속 받은 타입이어야 한다든지, 특정 프로토콜을 준수하는 타입이여야 한다는 등의 제약을 줄 수 있다는 뜻입니다.
    타입제약은 클래스 타입 또는 프로토콜로만 줄 수 있습니다. 즉 열거형, 구조체등의 타입은 타입 제약의 타입으로 사용될 수
    없습니다. 예를 들어 우리가 자주 사용하는 제네릭 타입인 Dictionary의 키는 Hashable 프로토콜을 준수하는 타입만 사용
    될 수 없습니다.
 */



/// 22-10 Dictionay 타입

/*
public struct Dictionary<Key: Hashable, Value> : Collection, ExpressibleByDictionaryLiteral {
    /* key 값은 Hashable 프로토콜을 준수한다는 의미이다. */
}
 */



/// 22-11 제네릭 타입 제약

/*
func swapTwoValues<T: Integer>(_ a : inout T, _ b: inout T) {
    // 함수 구현
}

struct Stack<Element: Hashabel> {
    // 구조체 구현
}
 
 여러 제약을 추가해 주고 싶다면 where절을 사용해 주면 된다.
*/



/// 22-12 제네릭 타입 제약 추가

/*
func swapTwoValues<T: Integer>(_ a inout T, _ b inout T) where T : FloatingPoint, T : Equatable {
    // 함수 구현
}
*/



/// 22-13 substractTwoValue 함수의 잘못된 구현

func substractTwoValue<T: Integer>(_ a: T, _ b: T) -> T {
    return a - b
}

/*
    타입 제약에 주로 사용할 프로토콜은 Hashable, Equatable, Comparable, Indexable, IteratorProtocol, 
    Error, Collection, CustomStringConvertible
 */


/// 22-15 makeDictionaryWithTwoValue 함수의 구현

func makeDIcionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
    
    let dictionary: Dictionary<Key, Value> = [key:value]
    return dictionary
}



/*
    프로토콜을 정의할 떄, 프로토콜 정의에 연관 타입을 정의하면 유용할 때가 있습니다. 연관 타입은 프로토콜에서 사용될 수 있는
    플레이스 홀더 이름입니다. 즉, 제네릭에서는 어떤 타입이 들어올지 모를떄, 타입 매개변수를 통해 ' 종류는 알 수 없지만, 어떤
    타입이 여기에 쓰일 것이다'라고 표현해주었다면 연관 타입은 타입 매개변수의 그 역활을 프로토콜에서 수행 할 수 있도록 
    만들어진 기능입니다.
 */

/// 22-16 Container 프로토콜 정의

protocol Container {
    associatedtype ItemType
    
    var count: Int { get }
    
    mutating func append( _ item: ItemType)
    
    subscript(i: Int) -> ItemType { get }
}



/// 22-17 MyContainer 클래스 정의 

class MyContainer: Container {
    var items: Array<Int> = Array<Int>()
    
    var count: Int {
        return items.count
    }
    
    func append(_ item: Int) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

/*
    프로토콜에서 ItemType 이라는 것을 하나의 타입으로 생각하고 그걸 따라서 상속받은 클래스에서 구현해 주면 된다.
 */



/// 22-18 IntStack 구조체의 Container 프로토콜 준수

struct IntStack1: Container {
    
    // 기존 IntStack 구조체 구현
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}



/// 22-19 IntStack 구조체의 typealias 사용

struct IntStack2: Container {
    typealias ItemType = Int
    
    // 기존 IntStack 구조체 구현
    var items = [ItemType]()
    mutating func push(_ item: ItemType) {
        items.append(item)
    }
    mutating func pop() -> ItemType {
        return items.removeLast()
    }
    
    //Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: ItemType) {
        self.push(item)
    }
    
    var count: ItemType {
        return items.count
    }
    
    subscript(i: ItemType) -> ItemType {
        return items[i]
    }
    
}



/// 22-20 Stack 구조체의 Container 프로토콜 준수 

struct Stack1<Element> : Container {
    
    //기존 Stack<Element> 구조체 구현
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}













 

