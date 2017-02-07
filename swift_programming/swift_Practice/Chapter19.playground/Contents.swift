//: Playground - noun: a place where people can play

import UIKit

/// Chapter19. 타입캐스팅

/*
    스위프트는 데이터 타입 안심을 위하여 각기 다른 타입끼리의 값 교환을 엄격히 제한합니다. 또, 다른 프로그래밍 언어에서
    대부분 지원하는 암시적 데이터 타입 변환은 지원하지 않습니다.
    
    스위프트에서 Int(2.3)처러 부동소수 타입을 정수 타입의 값으로 변환해주는 형태와 C언어의 데이터 타입 변환의 형태는 크게
    다를 것 없어 보이지만 사실은 사뭇 다릅니다.
 */



/// 19-1 C언어와 스위프트의 데이터 타입 변환 비교

// C 언어

/*
double value = 3.3
int convertedValue = (int)value
convertedValue = 5.5    // double -> int 암시적 데이터 타입 변환
*/

// 스위프트
var value: Double = 3.3
var convertedValue: Int = Int(value)
//convertedValue = 5.5 // 오류



/*
    스위프트에서 Int(value)는 Int라는 구조체이 있는 이니셜라이즈 입니다.
    이니셜라이즈를 통해 새로운 인스턴스를 생성하는 과정이죠.
 */

/// 19-2 Int 구조체의 다양한 이니셜라이저 정의 

/*
public struct Int : SignedInteger, Comparable, Equatable {
    
    /// Create an instance initalized to zero.
    public init()
    
    /*  중략... */
    public init(_ value: UInt8)
    ...
    
}
*/

/*
    Int의 이니셜라이저는 대부분 실패하지 않는 이니셜라이저로 정의되어 있습니다.
    그러나 조금 더 살펴보면 실패 가능한 이니셜라이저도 포함되어 있습니다. 바로 String 타입을 매개변수로 받는 
    public init?(_ text: String, radix: Int = default) 이니셜라이저가 실패 가능한 이니셜라이저입니다.
    String 타입의 데이터 text를 Int 타입으로 변경할 떄, 적절하지 못한 매개변수가 전달된다면 새로운 인스턴스가
    생성되지 않을 수 있다는 뜻입니다.
 */



/// 19-3 실패 가능한 Int 이니셜라이저

var stringValue: String = "123"
var integerValue: Int? = Int(stringValue)

print(integerValue) // Optional(123)

stringValue = "A123"
integerValue = Int(stringValue)

print(integerValue)



/*
    스위프트의 타입캐스팅
 
    스위프트에서는 다른 언어의 타입 변환 혹은 타입캐스팅을 이니셜라이저로 단순화했습니다. 그렇다면 스위프트에는 타입캐스팅이 
    없나요? 스위프트에도 타입캐스팅은 있으며 대신 조금 다른 의미로 사용됩니다. 
    ' 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세할 수 있는 방법으로 사용될 수
    있습니다. ' 
    스위프트의 타입캐스팅은 is 와 as 연산자로 구현되었습니다. 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환
    할수 있습니다. 타입캐스팅을 통해 프로토콜을 준수하는지도 확인해 볼 수 있습니다. 스위프트의 타입캐스팅은 실질적으로 참조
    타입에서 주로 사용됩니다.
 */

/// 19-4 Coffee 클래스와 Coffee 클래스를 상속받은 Latte와 Americano 클래스

class Coffee {
    let name: String
    let shot: Int
    
    var desciption: String {
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot:Int) {
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee {
    var flavor: String
    
    override var desciption: String {
        return "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int) {
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americano: Coffee {
    let iced: Bool
    
    override var desciption: String {
        return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool) {
        self.iced = iced
        super.init(shot: shot)
    }
}



/*
    데이터 타입 확인
    타입 확인 연산자인 is를 사용하여 인스턴스가 어떤 클래스(혹은 어떤 클래스의 자식클래스)의 인스턴스인지 타입을 확인해볼
    수 있습니다. 타입 확인 연산자는 인스턴스가 해당 클래스의 인스턴스거나 그 자식 클래스의 인스턴스라면 true를 반환하고, 
    그렇지 않다면 false를 반환합니다. is 연산자는 클래스의 인스턴스뿐만 아니라 모든 데이터 타입에 사용할수 있습니다.
 */

/// 19-5 데이터 타입 확인

let coffee: Coffee = Coffee(shot: 1)
print(coffee.desciption)    // 1 shot(s) coffee

let myCoffee: Americano = Americano(shot: 2, iced: false)
print(myCoffee.desciption)  // 2 shot(s) americano

let yourCoffee: Latte = Latte(flavor: "green", shot: 3)
print(yourCoffee.desciption)    // 3 shot(s) latte

print(coffee is Coffee) // true
print(coffee is Americano)  // false
print(coffee is Latte)  // false

print(myCoffee is Coffee)   // true
print(yourCoffee is Coffee) // true

print(myCoffee is Latte)    // false
print(yourCoffee is Latte)  // true



/*
    메타 타입
    is 연산자 외에도 타입을 확인해볼 수 있는 방법이 있습니다. 메타 타입을 이용하는 것입니다.
    메타 타입 타입은 타입의 타입을 뜻합니다. 클래스 타입, 구조체 타입, 열거형 타입, 프로토콜 타입등의 타입입니다.
    즉, 타입 자체가 하나의 타입으로 또 표현이 될 수 있다는 것입니다. 클래스, 구조체, 열거형의 이름은 타입의 이름입니다.
    그 타입의 이름 뒤에 .Type을 붙여 쓰면 이는 메타 타입을 나타냅니다. 프로토콜 타입의 메타 타입은 .Protocol 이라고 
    붙여주면 됩니다. 예를 들어 SomeClass 라는 클래스의 메타 타입은 SomeClass. Type이라고 표현하며, SomeProtocol의
    메타 타입은 SomeProtocol .Protocol 이라고 표현합니다.
 
    또, self를 사용해서 타입을 값처럼 표현할 수 있습니다. 예를 들어 SomeClass .self라고 표현하면 SomeClass의 인스턴스
    가 아니라 SomeClass 타입을 값으로 표현한 값을 반환합니다. 그리고 SomeProtocol .self라고 표현하면 SomeProtocol
    을 준수하는 타입의 인스턴스가 아니라 SomeProtocol 프로토콜을 값으로 표현한 값을 반환합니다.
 */

/// 19-6 메타 타입

protocol SomeProtocol {}
class SomeClass : SomeProtocol {}

let intType: Int.Type = Int.self
let stringType: String.Type = String.self
let classType : SomeClass.Type = SomeClass.self
let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self

var someType: Any.Type

someType = intType
print(someType) // Int

someType = stringType
print(stringType)

someType = classType
print(someType)

someType = protocolProtocol
print(someType)



/// 19-7 type(of:) 함수와 .self의 사용

print(type(of: coffee) == Coffee.self)  // ture
print(type(of: coffee) == Americano.self)   // false
print(type(of: coffee) == Latte.self)   // true

print(type(of: coffee) == Americano.self)   // false
print(type(of: myCoffee) == Americano.self) // true
print(type(of: yourCoffee) == Americano.self)  // false

print(type(of: coffee) == Latte.self)  // false
print(type(of: myCoffee) == Latte.self) // fasle
print(type(of: yourCoffee) == Latte.self)   // true



/// 19-8 Latte 타입의 인스턴스를 참조하는 Coffee 타입 actiongConstant 상수

let actiongConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
print(actiongConstant.desciption)   // 2 shot(s) vanilla latte



/*
    다운 캐스팅
 
    클래스의 상속 모식도에서 자식클래스보다 더 상위에 있는 부모클래스의 타입을 자신클래스의 타입으로 캐스팅한다고 해서 
    다운 캐스팅이라고 부릅니다. 
 
    타입캐스트 연산자에는 as?와 as! 두 가지가 있습니다. 타입캐스트 연산자를 사용하여 자식클래스 타입으로 다운캐스팅할 수 
    있습니다. ?와 !가 붙는 것을 보면 눈치챘겠지만, 다운캐스팅은 실패의 여지가 충분히 있기 때문에 ?가 붙은 연산자와 !가 붙은
    연산자 두 종류가 있습니다.
 */

/// 19-9 다운캐스팅

if let actingOne: Americano = coffee as? Americano {
    print("This is Americano")
} else {
    print(coffee.desciption)
}

// 1 shot(s) coffee

if let actingOne: Latte = coffee as? Latte {
    print("This is Latte")
}else {
    print(coffee.desciption)
}
// 1 shot(s) coffee

if let actingOne: Coffee = coffee as? Coffee {
    print("This is Just Coffee")
}else {
    print(coffee.desciption)
}
// This is Just Coffee

if let actingOne: Americano = myCoffee as? Americano {
    print("This is Just Americano")
}else {
    print(myCoffee.desciption)
}

// This is Jus Americano

if let actingOne: Latte = myCoffee as? Latte {
    print("This is Just Latte")
}else {
    print(coffee.desciption)
}

// 1 shot(s) coffee

if let actingOne: Coffee = myCoffee as? Coffee {
    print("This is Just Coffee")
}else {
    print(coffee.desciption)
}

//This is Just Coffee

// Success
let castedCoffee: Coffee = yourCoffee as! Coffee

// 런타임 오류!!! 강제 다운캐스팅 실패!
//let castedAmericano: Americano = coffee as! Americano



/// 19-10 항상 성공하는 다운캐스팅
// 항상 성공하는 다운 캐스팅
//let castedCoffee : Coffee = yourCoffee as Coffee



/*
    Any, AnyObject의 타입캐스팅 
 
    Any는 함수를 포함한 모든 타입을 뜻하고, AnyObject는 클래스 타입만을 뜻합니다.
 */



/// 19-11 AnyObject의 타입 확인

func checkType(of item: AnyObject) {
    
    if item is Latte {
        print("item is Latte")
    } else if item is Americano {
        print("item is Americano")
    } else if item is Coffee {
        print("item is Coffe")
    } else {
        print("Unknwon Type")
    }
}

checkType(of: coffee)
checkType(of: myCoffee)
checkType(of: yourCoffee)
checkType(of: actiongConstant)



/// 19-12 AnyObject의 타입캐스팅

func castTypeToAppropriate(item: AnyObject) {
    
    if let castedItem: Latte = item as? Latte {
        print(castedItem.desciption)
    } else if let castedItem: Americano = item as? Americano {
        print(castedItem.desciption)
    } else if let castedItem : Coffee = item as? Coffee {
        print(castedItem.desciption)
    } else {
        print("Unknwon Type")
    }
}

castTypeToAppropriate(item: coffee)
castTypeToAppropriate(item: myCoffee)
castTypeToAppropriate(item: yourCoffee)
castTypeToAppropriate(item: actiongConstant)



/// 19-13 Any의 타입 캐스팅

func checkAnyType(of item: Any) {
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I doun't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x,y) as (Double,Double):
        print("an (x,y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.desciption)
    case let stringConverter as (String) -> String:
        print(stringConverter("yagom"))
    default :
        let type: String = String(describing: type(of: item))
        print("something else : \(type)")
    }
}

checkAnyType(of: 0)
checkAnyType(of: 0.0)
checkAnyType(of: 42)
checkAnyType(of: 3.14159)
checkAnyType(of: -0.25)
checkAnyType(of: "hello")
checkAnyType(of: (3.0,5.0))
checkAnyType(of: yourCoffee)
checkAnyType(of: coffee)
checkAnyType(of: { (name: String) -> String in "Hello, \(name)" })



 
 