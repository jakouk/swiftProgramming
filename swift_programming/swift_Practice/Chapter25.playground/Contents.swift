//: Playground - noun: a place where people can play

import UIKit

/// Chapter25. 패턴 

/*
    스위프트에는 문법에 응용할 수 있는 다양한 종류의 패턴이 있습니다. 여러 패턴을 잘 알아두고 숙지해두면 스위프트 코드의 양을 
    줄이는 효과는 물론, 스위프트 문법을 좀 더 잘 활용할수 있습니다. 패턴은 '단독 또는 복합 값의 구조를 나태내는 것'이고, 
    패턴 매칭는 ' 코드에서 어떤 패턴의 형태를 찾아내는 행위'라고 할 수 있습니다. 뜻만 놓고 보면 크게 와닿지 않을 겁니다.
    쉽게 말하면 '이러이러한 것을 표현하고 싶다'면 '이러이러한 패턴을 통해 표현하면 된다'라고 이해하시면 됩니다. 대부분의 패턴은
    switch, if, guard, for 등의 키워드와 아주 친하며 두 개 이상의 키워드가 합을 이뤄 동작합니다. 예제에서 볼 수 있겠지만
    , 대부분의 패턴은 switch 구문에서 강력한 힘을 발휘합니다. 
 
    스위프트의 패턴은 크게 두 종류로 나뉩니다.
    
    1. 값을 해체(추출)하거나 무시하는 패턴 -> 와일드카드 패턴, 식별자 패턴, 값 바인딩 패턴, 듀플 패턴
    2. 패턴 매칭을 위한 패턴 -> 열거형 케이스패턴, 옵셔널 패턴, 표현 태턴, 타입캐스팅 패텅
 */



/// 25-1 와일드카드 패턴의 사용

let string: String = "ABC"

switch string {
case _: print(string)   // 어떤 값이 와도 상관없기에 항상 실행됩니다.
}

let optionalString: String? = "ABC"

switch optionalString {
case "ABC"?:
    print(optionalString)
case _?:
    print(optionalString)
case nil:
    print("nil")
}

let yagom = ("yagom",99,"Male")

switch yagom {
case ("yagom",_,_):
    print("Hello yagom!!")
case (_,_,_):
    print("Who cares~")
}

for _ in 0..<2 {
    print("Hello")
}



/// 25-2 식별자 패턴의 사용

let someValue: Int = 42



/// 25-3 값 바인딩 패턴 

// let yagom = ("yagom",99, "Male")

switch yagom {
    // name, age, gender를 yagom의 각각의 요소와 바인딩합니다.
case let (name, age, gender) : print("Name:\(name), Age: \(age), Gender:\(gender)")
    
}

switch yagom {
case (let name, let age, let gender ) : print("Name: \(name), Age: \(age), Gender: \(gender)")
}

switch yagom {
case (let name, _, let gender): print("Name: \(name), Gender: \(gender)")
}



/*
    튜플 패턴
 
    튜플 패턴은 소괄호( () ) 내에 쉼표로 분리되는 리스트입니다. 듀플 패턴은 그에 상응하는 튜플 타입과 값을 매치합니다.
    예를 들어 let (x, y) : (Int, Int) = (1, 2)와 같이 상수를 선언한다면 (x, y): (Int, Int)라고 사용된 튜플
    패턴은 요소가 모두 Int 타입인 튜플하고만 매치된다는 뜻입니다.
 
    튜플 패턴이 for-in 구문 또는 변수나 상수 선언에서 사용된다면 와일드 카드 패턴, 식별자 패턴, 옵셔널 패턴, 또다른 튜플
    패턴등을 함께 사용할 수 있습니다.
 */

/// 25-4 튜플 패턴

let (a) : Int = 2
print(a)    // 2

let (x, y): (Int, Int) = (1, 2)
print(x)    // 1
print(y)    // 2

let name: String = "Jung"
let age: Int = 99
let gender: String? = "Male"

switch (name, age, gender) {
case ("Jung",_,_): print("Hello Jung!!")
case (_,_,"Male"?): print("Who are you man?")
default: print("I don't know who you are")
}

let points: [(Int, Int)] = [(0,0), (1,0), (1,1), (2,0), (2,1)]

for (x,_) in points {
    print(x)
}



/// 25-5 열거형 케이스 패턴의 사용

let someValue1: Int = 30

if case 0...100 = someValue1 {
    print("0 <= \(someValue1) <= 100")
}

let anotherValue: String = "ABC"

if case "ABC" = anotherValue {
    print(anotherValue)
    // ABC
}

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dishes: [MainDish] = []

var dinner: MainDish = .pasta(taste: "크림")  // 크림 파스타

if case .pasta(let taste) = dinner {
    print("\(taste) 파스타")
}   // 크림 파스타

dinner = .pizza(dough: "치즈크러스트", topping: "불고기")    // 치즈크러스트, 불고기
dishes.append(dinner)

func whatIsThis(dish: MainDish) {
    guard case .pizza(let dough, let topping) = dinner else {
        print("It's not a Pizza")
        return
    }
    
    print("\(dough) \(topping)")
}

whatIsThis(dish: dinner)

dinner = .chicken(withSauce: true) // 양념 통닭 만들기
dishes.append(dinner)

while case .chicken(let sauced) = dinner {
    print("\(sauced ? "양념" : "후라이드") 통닭")
    break
}

dinner = .rice  // 밥
dishes.append(dinner)

if case .rice = dinner {
    print("오늘 저녁은 밥입니다.")
}

for dish in dishes {
    switch dish {
    case let .pasta(taste) : print(taste)
    case let .pizza(dough, topping) : print("\(dough, topping)")
    case let .chicken(sauced): print(sauced ? "양념" : "후라이드")
    case .rice: print("Just 쌀")
    }
}



/// 25-6 옵셔널 패턴의 사용

var optionalValue: Int? = 100

if case .some(let value) = optionalValue {
    print(value)
}

if case let value? = optionalValue {
    print(value)
    // 100
}

func isItHashValue(_ optionalValue: Int? ) {
    guard case .some(let value) = optionalValue else {
        print("none")
        return
    }
    print(value)
}

isItHashValue(optionalValue)

while case .some(let value) = optionalValue {
    print(value)
    optionalValue = nil
}   // 100

print(optionalValue)

let arrayOfPotionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfPotionalInts {
    print("Found a \(number)")
}



/// 25-7 타입캐스팅 패턴

let someValue2: Any = 100

switch someValue2 {
    // 타입이 Int인지 확인하지만 캐스팅된 값을 사용할 수는 없습니다.
case is String: print("It's String!")
    
    // 타입 확인과 동시에 캐스팅까지 완료되어 value에 저장됩니다.
    // 값 바인딩 패턴과 결합된 모습입니다.
case let value as Int: print(value + 1)
default: print("Int도 String도 아닙니다")
}   // 101



/// 25-8 표현 패턴의 사용

switch 3 {
case 0...5: print("0과 5 사이")
default: print("0보다 작거나 5보다 큽니다.")
}

var point: (Int, Int) = (1, 2)

// 같은 타입 간의 비교이므로 == 연산자를 사용하여 비교할 것입니다.
switch point {
case(0,0): print("원점")
case(-2...2, -2...2): print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default: print("point (\(point.0), \(point.1)")
}   // (1,2)는 원점과 가깝습니다.

// String 타입과 Int 타입이 매치될 수 있도록 ~= 연산자를 정의합니다.

func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}

point = (0,0)

// 새로 정의된 ~= 연산자를 사용하여 비교합니다.
switch point {
case ("0","0"): print("원점")
default: print("point (\(point.0), \(point.1))")
}
// 원점

switch point {
case (0, 0): print("원점")
case (-2...2, -2...2): print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default:print("point (\(point.0), \(point.1))")
}

struct Person {
    var name: String
    var age: Int
}

let lingo: Person = Person(name: "Lingo", age: 99)

func ~= (pattern: String, value: Person) -> Bool {
    return pattern == value.name
}

func ~= (pattern: Person, value: Person) -> Bool {
    return pattern.name == value.name && pattern.age == value.age
}

switch lingo {
case "Lingo":print("Hello Lingo!!")
case Person(name: "Lingo", age: 99): print("Same Person!!")
default: print("I don't know who you are")
}   // Same Person!!



/*
    표현 패턴
    표현 패턴은 표현의 값을 나타냅니다. 표현 패턴은 switch 구문의 case 레이블에서만 사용할 수 있습니다.
    표현 패턴은 스위프트 표준 라이브러리의 패턴 연산자인 ~= 연산자의 연산 결과가 true를 반환하면 매치시킵니다. ~= 연산자는 
    같은 타입의 두 값을 비교할 때 == 연산자를 사용합니다. 표현 패턴은 정수 값과 저수의 범위를 나타내는 Range 객체와 매치시킬
    수도 있습니다.
    표현 패턴은 매우 유용한 패턴 중 하나입니다. 사실 모든 패턴 중에 최고봉이며 궁극의 패턴매칭을 이루어 낼 수 있는 패턴이라고
    할 수 있습니다. 그 이유는 ~= 연산자를 중복 정의 하거나 ~= 연산자를 새로 정의하거나 또는 자신이 만든 타입에 ~= 연산자를
    구현해 준다면 자신이 원하는대로 패턴을 완성시킬 수 있기 때문입니다. 거기에 더불어 제네릭까지 추가하면 활용도는 더욱 높아집니다
 */

/// 25-9 제네릭을 사용한 표현 패턴 활용

// 제네릭을 사용하기 위해 프로토코을 정의합니다.
protocol Personalize {
    var name: String { get }
    var age: Int { get }
}

struct Person1: Personalize {
    var name: String
    var age: Int
}

let star: Person1 = Person1(name: "Star", age: 99)

/* 이제 필요 없습니다. - 제네릭을 이용해서 구현할 거니까요
func ~= (pattern: String, value: Person1) -> Bool {
    return pattern == value.name
}

func ~= (pattern: Person1, value: Person1) {
    return pattern.name == value.name && pattern.age == value.age
}

*/

func ~= <T: Personalize>(pattern: String, value: T) -> Bool {
    return pattern == value.name
}

func ~=<T: Personalize>(pattern: T, value: T) -> Bool {
    return pattern.name == value.name && pattern.name == value.name
}

// 기존 패턴 연산자가 없더라도 제네릭 패턴 연산자로 똑같이 사용할 수 있습니다.
switch star {
case Person1(name: "Star", age: 99): print("Same Person!!")
    case "Star": print("Hello Star!!")
default: print("I don't know who you are")
}   // Same Person!!

// 이번엔 제네릭을 사용하여 패턴 연산자를 정의합니다.
// 패턴 자체가 함수임을 유심히 살펴보세요!
func ~= <T:Personalize>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

// 패턴에 사용될 제네릭 함수입니다.
func young<T: Personalize>(value: T) -> Bool {
    return value.age < 50
}

switch star {
    // 패턴결합을 하면 young(star)와 같은 효과를 봅니다.
case young: print("\(star.name) is young")
default: print("\(star.name) is old")
}

// 패턴에 사용될 제네릭 함수입니다.
func isNamed<T: Personalize>(_ pattern: String) -> ((T) -> Bool) {
    return { (value: T) -> Bool in value.name == pattern }
}

switch star {
    // 패턴결합을 하면 isNamed("jung")(star)와 같은 효과를 봅니다.
case isNamed("Jung"): print("He is Jung")
default: print("Another person")
}   // Another Person

// 연산자 함수라는 점을 생각해보면 이런 방식으로도 구현할 수 있습니다.
prefix operator ==?

prefix func ==? <T: Personalize>(pattern: String) -> ((T) -> Bool) {
    return isNamed(pattern)
}

switch star {
    // 패턴 결합을 하면 isNamed("Jung")(star)와 같은 효과를 봅니다.
    case ==?"Jung":print("He is Jung")
default: print("Another person")
}   // Another person

/*

 */
