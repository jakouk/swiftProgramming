//: Playground - noun: a place where people can play

import UIKit

/* 
     Chapter 5. 연산자
    스위프트 연산자는 특정한 문자로 표현한 함수라 할 수 있습니다. 
    따라서 특정 연산자의 역할을 프로그래머의 의도대로 변경할 수도 있습니다. 
 
    연산자에 의해 연산되는 값의 수에 따라 단항, 이항, 삼항 등으로 구분하기도 하며, 연산자의 위치에 따라 전위, 중위 후위 등으
    구분하기도 합니다.
 
 */

/*
 
     띄어쓰기와 연산자
    스위프트에서는 띄어쓰기도 중요한 문법 중 하나압니다. 연산가자 어디에 위치하느냐도 중요하지만, 연산자의 앞과 뒤 중 어디에
    공백이 있는지도 중요한 부분입니다. 예를 들어, A != B 와 A! = B 는 전혀 다른 의미가 됩니다. 
    A>B?A:B는 잘못된 사용이며 물음표를 B에서 띄어 써야 합니다.
 
 */

/*
 
     스위프트의 나머지 연산과 나누기 연산자
    스위프트에서는 부동소수점 타입의 나머지 연산까지 지원합니다. 기존의 프로그래밍 언어에서는 나머지 연산자가 정수형에만 
    해당되는 경우가 많았는데 스위프트에서는 부동소수점 타입도 나머지 연산을 할 수 있습니다. 
 
    let number: Double = 5.0
    var result: Double = number.truncationRemainder(dividingBy: 1.5)    //0.5
    result = 12.truncationRemainder(dividingBy: 2.5)    //2.0
 
    나머지 연산은 기존의 프로그래밍 언어처러 나머지나 소수점을 제외한 정수만을 결과값으로 반환합니다. 
 
    var result: Int = 5 /3 //1
    result = 10 / 3 //3
 
    또한 스위프트는 데이터 타입에 굉장히 엄격하므로 서로 다른 자료형끼리의 연산을 엄격히 제한합니다. 서로 자료형끼리의 연산을
    수행하려면 값을 해당 타입으로 변환한 후 연산해야 합니다. 심지어 같은 정수 타입인 Int 타입과 UInt 타입끼리의 연산도
    엄격하게 제한됩니다.
 
 */

/*
 
     참조비교 연산자 
 
    스위프트의 유일한 참조타입인 클래스의 인스턴스에서만 참조비교 연산자를 사용할 수 있습니다.( 물론 다른 데이터 타입에서 === 
    등의 연산자를 프로그래머가 정의하면 다른 용도로 사용이 가능합니다.) 스위프트의 기본 데이터 타입은 모두 구조체로 구현되어 
    있기 때문에 값의 비교연산에서는 ==를 사용하고 클래스의 인스턴스인 경우에만 ===를 사용합니다. 구조체와 클래스, 값 타입과 
    참조타입에 대해서는 닶 타입과 참조타입에서 더 자세히 알아보도록 하겠습니다.
 
 
    참조가 같다 A === B
    참조가 같지 않다 A !== B
    패턴 매치   A ~= B ( A와 B의 패턴이 매치되는지 확인하여 불리언 값을 반환합니다. )
 
    let valueA: Int = 3
    let valueB: Int = 5
    let valueC: Int = 5
 
    let isSameValueAB: Bool = valueA == valueB  //false
    let isSameValueBC: Bool = valueB == valueC  //true
 
    let referenceA: SomeClass = SomeClass()
    let referenceB: SomeClass = SomeClass()
    let referenceC: SomeClass = referenceA
 
    let isSameReferenceAB: Bool = referenceA === referenceB //false
    let isSameReferenceAC: Bool = referenceA === referenceC //true
 
 */

/// 5-1 삼항 조건 연산자의 사용

var valueA: Int = 3
var valueB: Int = 5

var biggerValue: Int = valueA > valueB ? valueA : valueB    // 5

valueA = 0
valueB = -3

biggerValue = valueA > valueB ? valueA : valueB // 0

var stringA: String = ""
var stringB: String = "String"

var resultValue: Double = stringA.isEmpty ? 1.0 : 0.0   //1.0
resultValue = stringB.isEmpty ? 1.0 : 0.0   //0.0



/*
 
    복합 할당 연산자
    A <<= N A를 N만큼 왼쪽 비트 쉬프트한 값에 A를 할당합니다.
    A >>= N A를 N만큼 오른쪽 비트 쉬프트한 값에 A를 할당합니다.
    A &= B A와 B의 비트 AND 연산 결과를 A에 할당합니다.
    A |= B A와 B의 비트 OR 연산 결과를 A에 할당합니다.
    A ^= B ( A = A ^ B)  A와 B의 비트 XOR 연산 결과를 A에 할당합니다.
 
    오버플로 연산자 
    &+ 오버플로에 대비한 덧셈 연산을 합니다.
    &- 오버플로에 대비한 뺄셈 연산을 합니다.
    &* 오버플로에 대비한 곱셈 연산을 합니다.
 
 */

/// 5-2 오버플로 연산자의 사용 

var unsignedInteger: UInt8 = 0
//let errorUnderflowResult: UInt8 = unsignedInteger -1    //런타임 오류 ( 범위 초과 )
let underflowedValue: UInt8 = unsignedInteger &- 1  //255

unsignedInteger = UInt8.max
//let errorOverflowResult: UInt8 = unsignedInteger + 1    //런타임 오류 ( 범위 초과 )
let overflowedVlaue: UInt8 = unsignedInteger &+ 1   //0


/* 
    기타 연산자 
 
    A ?? B  A가 nil이 아니면 A를 반환하고, A가 nil이면 B를 반환합니다.
    -A A(수)의 부호를 변경 합니다.
    O!  O(옵셔널 개체)의 값을 강제로 추출합니다.
    V? V(옵셔널 값)를 안전하게 추출하거나, V(데이터 타입)가 오셔널임을 표현합니다.
 */

/*
 
    nil 병합 연산자
    nil 병합 연산자는 옵셔널을 사용할 때 아주 유용하게 사용될 수 있는 연산자입니다.
    아직 옵셔널에 대해 배우지 않났지만 차후 옵셔널을 배우고 nil 병합 연산자를 다시 확인해보기 바랍니다.
    다음 두 코드는 같은 역항을 하는 코드지만, 아래 nil 병합 연산자를 사용하는 것이 훨씬 안전하고 간단한 방법입니다.
 
    let valueInt: Int = someOptionalInt != nil ? someOptionalInt! : 0
 
    //위의 코드와 같은 결과를 볼 수 있지만 훨씬 안전하게 옵셔널을 다룰 수 있습니다
    
    let valueInt: Int = someOptionalInt ?? 0
 
    옵셔널 강제 추출 연산자는 사용을 지양하는 편이 좋습니다.
 
 */



/// 5 - 5 연산자 우선순위에 따른 처리 순서

let intValue: Int = 1
let resultVlaue1: Int = intValue << 3 + 5   // 1을 왼쪽 쉬프트 3 하고 ( 8 + 5
let resultValue2: Int =  1 * 3 + 5




/*
    사용자 정의 연산자 
 
    할당 연산자(=)와 삼항 연산자(?:)는 사용자정의 역할을 부여할 수 없습니다.
 
    기존 연산자의 역할을 변경하거나 새로운 역할을 추가하기 위해서는 기존 연산자가 전위, 중위, 후위 연산자인지 
    알고 있어야 한다. 
    
    연산자 정의
    infix는 중위연산자
    prefix는 전위연산자
    postfix는 후위연산자
 
    키워드
    operator 는 연산자
    associativity는 연산자 결합방향
    precedence는 우선순위 
 
    사용자 정의 연산자는 아스키문자를 결합해서 사용합니다.

    (.)도 사용자정의 연산자로 사용될수 있으며 문자 중 맨 처음 문자가 마침표 일때에만 연산자로 인식됩니다.
    .+. , .+ 는 인식되지만 +.+는 +와 .+로 인식됩니다. 
 
    (? , !)도 사용자정의 연산자로 사용될수 있지만 그 자체만으로는 사용이 불가능 합니다.
 
 
 */



/// 5 - 6 전위 연산자 정의

prefix operator **



/// 5 -7 전위 연산자 구현과 사용

prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)    //25 



/// 5 - 8 전위 연산자 함수 중복 정의와 사용

prefix func ! (value: String) -> Bool {
    return value.isEmpty
}

var stringValue: String = "yagom"
var isEmptyString: Bool = !stringValue

print(isEmptyString)    //false

stringValue = ""
isEmptyString = !stringValue

print(isEmptyString)    //true



/// 5 - 9 사용자정의 전위 연산자 함수 중복 정의와 사용

prefix func ** (value: String) -> String {
    return value + " " + value
}

let resultString: String = **"yagom"

print(resultString) //yagom yagom



/// 5 - 10 사용자정의 후위 연산자와 함수 구현

postfix operator **

postfix func ** (value: Int) -> Int {
    return value + 10
}

let five: Int = 5
let fivePlusTen = five**

print(fivePlusTen)



/// 5 - 11 전위 연산자와 후위 연산자 동시 사용

/*
    전위와 후위를 같이 사용하면 후위부터 먼저 연산을 시작한다.
 */

let sqrtFivePlusTen: Int = **five**

print(sqrtFivePlusTen)  // ( 10 + 5 ) * ( 10 * 5 )



/*
 
    중위 연산자
 
    precedencegroup 우선순위 그룹 이름 {
        higherThan : 더 낮은 우선순위 그룹 이름
        lowerThan : 더 높은 우선숭위 그룹 이름
        associativity: 결합방향 ( left / right / none )
        assignment : 할당방향 사용 ( true / false )
    }
 
    결합방향이 none 이면 한번만 사용가능
    결합방향이 right, left는 여러번 사용가능
 
    assignment 옵셔널 체이닝과 관련된 사항.
 
    true를 하면 오른쪽 부터 연산
    false를 하면 왼쪽 부터 연산
 
    만약 중위 연산자를 정의할 떄 수선순위 그룹을 명시해 주지 않으면 DefaultPrecedence 그룹을 우선순위 그룹으로 가지게됨.
 */

/// 5 - 12  중위 연산자의 정의 

infix operator ** : MultiplicationPrecedence



/// 5 - 13 중위 연산자의 구현과 사용

//String 타입의 contains(_:) 메서드를 사용하기 위해 Foundation 프레임워크를 임포트 합니다.

import Foundation
func ** (lhs: String, rhs: String) -> Bool {
    return lhs.contains(rhs)
}

let helloYagom: String = "Hello yagom"
let yagom: String = "yagom"

let isContainsYagom: Bool = helloYagom ** yagom     //true



/// 5 - 14 클래스 및 구조체의 비교 연산자 구현

/*
class Car {
    var modelYear: Int? //연식
    var modelName: String? //모델 이름
}

struct SmartPhone {
    var company: String?    //제조사
    var model: String?  //모델
}

//Car 클래스의 인스턴스끼리 == 연산을 하였을 때 modelName이 같다면 true를 반환
func == (lhs: Car, rhs: Car) -> Bool {
    return lhs.modelName == rhs.modelName
}

//SmartPhone 구조체의 인스턴스끼리 == 연산을 하였을 떄 model이 같다면 true를 반환
func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
    return lhs.model == rhs.model
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar) //true
print(myPhone == yourPhone) //true
*/


///5 - 15 타입 메서드로 구현된 사용자정의 비교 연산자

class Car {
    var modelYear: Int? //연식
    var modelName: String? //모델 이름
    
    //Car 클래스의 인스턴스끼리 == 연산을 하였을 때 modelName이 같다면 true를 반환
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.modelName == rhs.modelName
    }
}

struct SmartPhone {
    var company: String? //제조자
    var model: String? //모델
    
    //SmartPhone 구조체의 인스턴스끼리 == 연산을 하였을 떄 model이 같다면 true를 반환
    static func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
        return lhs.model == rhs.model
    }
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar) //true
print(myPhone == yourPhone) //true










