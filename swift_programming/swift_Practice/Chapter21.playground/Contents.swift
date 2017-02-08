//: Playground - noun: a place where people can play

import UIKit

/// Chapter21. 익스텐션

/*
    익스텐션
 
    인스텐션은 스위프트의 강력한 기능 중 하나입니다. 익스텐션은 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 
    수 있는 기능입니다. 기능을 추가하려는 타입의 구현된 소스 코드를 알지 못하거나 볼 수 없다 해도, 타입만 알고 있다면 그 타입의
    기능을 확장할 수도 있습니다. 익스텐션은 Objective-C의 카테고리와 유사한 기능입니다. Objective-C의 카테고리는 
    카테고리마다 이름을 명명했지만 스위프트의 익스텐션은 이름이 없습니다.
 
    스위프트의 익스텐션이 타입에 추가할 수 있는 기능은 다음과 같습니다. 
 
    연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
    타입 메서드/ 인스턴스 메서드
    이니셜라이저
    서브스크립트
    중첩타입
    특정 프로토콜을 준수할 수 있도록 기능 추가 
 
    익스텐션은 타입에 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없습니다. 클래스의 상속과
    익스텐션을 비교해보겠습니다. 이 둘은 비슷해보이지만 실제 성격은 많이 다릅니다. 
 
    클래스의 상속은 클래스 타입에서만 가능하지만 익스텐션은 구조체, 클래스, 프로토콜 등에 적용이 가능합니다. 또 클래스의 
    상속은 특정 타입을 물려받아 하나의 새로운 타입을 정의하고 추가 기능을 구현하는 수직 확장이지만, 익스텐션은 기존의 타입에
    기능을 추가하는 수평확장입니다. 또, 상속을 받으면 기존 기능을 재정의할 수 있지만, 익스텐션은 재정의할 수 없다는 것도
    큰 차이 중 하나입니다. 상황과 용도에 마게 상속과 익스텐션을 선택하여 사용하면 됩니다.
 */



/*
    인스텐션의 문법 
 
    익스텐션은 extension 이라는 키워드를 사용하여 선언 합니다.
 
    extension 확장할 타입 이름 {
        // 타입에 추가될 새로운 기능 구현
    }
 
    익스텐션은 기존에 존재하는 타입이 추가적으로 다른 프로토콜을 채택할 수 있도록 확장할 수도 있습니다. 이런 경우에는 클래스나
    구조체에서 사용하던 것과 똑같은 방법으로 프로토콜이름을 나열해 줍니다.
 
    extension 확장할 타입 이름: 프로토콜 1, 프로토콜 2, 프로토콜 3 {
        // 프로토콜 요구사항 구현
    }
 
    스위프트 라이브러리를 살펴보면 실제로 익스텐션이 괸장히 많이 사용되고 있음을 알 수 있습니다. Double 타입에는 수많은 
    프로퍼티와 메서드, 이니셜라이저가 정의되어 있으며 수많은 프로토콜을 채택하고 있을 것이라고 예상하지만, 실제로는 Double
    타입의 정의흫 상펴보면 그 모든 것이 다 정의되어 있지는 않습니다.
 */



/// 21-1 스위프트 표준 라이브러리의 Double 타입 정의

/*
/// A double-precision, floating-point value type.
public struct Double {
    public init()
    public init(_ v: UInt8)
    public init(_ v:Int8)
    ...
}
 */

/*
    그러면 Double 타입이 채택하고 준수해야 하는 수많은 프로토콜은 어디로 갔을까요? 어디에서 채택하고 어디에서 준수하도록 정의
    되어 있을까요? 당연히 답은 익스텐션입니다. Double 타입에 적용된 익스텐션 중 아주 일부분 입니다.
 */



/// 21-2 스위프트 표준라이브러리의 Double 타입에 구현된 익스텐션의 일부 코드 

/*
extension Double : CustomStringConvertible {
    /// A textual representation of the value 
    public var desription: String { get }
}

extension Double : CustomDebugStringConvertible {
    /// A textual representation of th value, suitable for debugging.
    public var debugDescription: String { get }
}
 */

/*
    이처럼 스위프트 표준 라이브러리 타입의 기능은 대부분 익스텐션으로 구현되어 있습니다.
    Double 이외에도 다른 타입들의 정의와 익스텐션을 찾아보면 더 많은 예를 보실 수 있습니다. 꼭 찾아보세요!!
 */



/// 21-3 익스텐션을 통한 연산 프로퍼티 추가

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    
    var isOdd: Bool {
        return self % 2 == 1
    }
}

print(1.isEven) // false
print(2.isEven) // true
print(1.isOdd)  // true
print(2.isOdd)  // false

var number: Int = 3
print(number.isEven)    // false
print(number.isOdd)     // ture

number = 2
print(number.isEven)    // true
print(number.isOdd)     // false

/*
    익스텐션으로 연산 프로퍼티를 추가할 수는 있지만, 저장 프로퍼티는 추가할 수 없습니다. 또, 타입에 정의되어 있는 기존의
    프로퍼티에 프로퍼티 감시자를 추가할 수도 없습니다.
 */



/// 21-4 익스텐션을 통한 메서드 추가

extension Int {
    func multiply(by n: Int) -> Int {
        return self * n
    }
    
    mutating func multiplySelf(by n:Int) {
        self = self.multiply(by: n)
    }
    
    static func isIntTypeInstance(_ instance: Any) -> Bool {
        return instance is Int
    }
}

print(3.multiply(by: 2))    // 6
print(4.multiply(by: 5))    // 20

var number1: Int = 3

number1.multiplySelf(by: 2)
print(number1)

number1.multiplySelf(by: 3)
print(number1)

Int.isIntTypeInstance(number1)  // true
Int.isIntTypeInstance(3)    // true
Int.isIntTypeInstance(3.0)  // false
Int.isIntTypeInstance("3")  // false

prefix operator ++

struct Position {
    var x: Int
    var y: Int
}

extension Position {
    // + 중위 연산 구현
    static func + (left: Position, right: Position) -> Position {
        return Position(x: left.x + right.x, y: left.y + right.y)
    }
    
    // - 전위 연산 구현
    static prefix func - (vector: Position) -> Position {
        return Position(x: -vector.x, y: -vector.y)
    }
    
    // += 복합할당 연산자 구현
    static func += (left: inout Position, right: Position) {
        left = left + right
    }
}

extension Position {
    // == 비교 연산자 구현
    static func == (left: Position, right: Position) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    // != 비교 연산자 구현
    static func != (left: Position, right: Position) -> Bool {
        return !(left == right)
    }
}

extension Position {
    
    // ++ 사용자정의 연산자 구현
    static prefix func ++ (position: inout Position) -> Position {
        position.x += 1
        position.y += 1
        return position
    }
}

var myPosition: Position = Position(x: 10, y: 10)
var yourPosition: Position = Position(x: -5, y: -5)

print(myPosition + yourPosition)
print(-myPosition)

myPosition += yourPosition
print(myPosition)

print(myPosition == yourPosition)
print(myPosition != yourPosition)

print(++myPosition)



/*
    이니셜라이저
 
    인스턴스를 초기화(이니셜라이저)할 떄 인스턴스 초기화레 필요한 다양한 데이터를 전달받을 수 있도록 여러 종류의 이니셜라이저를
    만들 수 있습니다. 타입의 정의부에 이니셜라이저를 추가하지 않더라도 익스텐션을 통해 이니셜라이저를 추가할 수 있습니다.
    하지만 익스텐션으로 클래스 타입에 편의 이니셜라이저는 추가할 수 있지만 지정 이니셜라이저는 추가할 수 없습니다. 지정 
    이니셜라이저와 디이니셜라이저는 반드시 클래스 타입의 구현부에 위치해야 합니다.
 */

/// 21-5 dlttmxpstusdmf xhdgks dlsltuffkdlwj cnrk

extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }
    
    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }
}

let stringFromInt: String = String(100) // "100"
let stringFromDouble: String = String(100.0)    // "100.0"

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person {
    convenience init() {
        self.init(name:"Unknown")
    }
}

let someOne: Person = Person()
print(someOne.name)

/*
    익스텐션으로 값 타입( 열거형, 구조체 등) 에 이니셜라이저를 추가했을 때, 그 값 타입이 다음의 조건을 모두 성립한다면 
    익스텐션으로 추가한 이니셜라이저에서 그 타입의 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 호출할 수 있습니다.
 
    1. 모든 저장 프로퍼티가 기본값을 가지고 있습니다.
    2. 타입이 기본 이니셜라이저와 멤버와아즈 이니셜라이저 외에 추가적인 사용자정의 이니셜라이저를 가지고 있지 않습니다.
 */



/// 21-6 익스텐션을 통한 초기화 위임 이니셜라이저 추가

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
}

let defaultRect: Rect = Rect()
let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX: Double = center.x - (size.width / 2)
        let originY: Double = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect: Rect = Rect(center: Point(x:4.0, y:4.0), size: Size(width: 3.0 , height: 3.0))



/// 21-7 익스텐션을 통한 서브스크립트 추가

extension String {
    subscript(appendValue: String) -> String {
        return self + appendValue
    }
    
    subscript(repeatCount: UInt) -> String {
        var str: String = ""
        
        for _ in 0..<repeatCount {
            str += self
        }
        return str
    }
}

print("abc"["def"]) // abcdef
print("abc"[3]) // abcabcabc



/// 21-8 익스텐션을 통한 중첩 데이터 타입 추가

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
        var Kind: Kind {
            switch self {
            case 0:
                return .zero
            case let x where x > 0:
                return .positive
            default:
                return .negative
        }
    }
}

print(1.Kind)
print(0.Kind)
print((-1).Kind)

func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.Kind {
        case .negative:
            print("- ", terminator:"")
        case .zero:
            print("0 ",terminator:"")
        case .positive:
            print("+ ",terminator:"")
        }
    }
    print("")
}

printIntegerKinds(numbers: [3, 19, -27, 0, -6, 0, 7])
// + + - 0 - 0 +



