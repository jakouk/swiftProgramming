//: Playground - noun: a place where people can play

import UIKit

/// Chapter8 옵셔널

/*
 스위프트의 특징 중 하나인 안정성을 문법적으로 담보하는 기능이 바로 옵셔널(Optional)입니다.
 C언어 또는 Objective-C에서는 찾아볼 수 없었던 컨셉으로 옵셔널은 단어 뜻 그대로 '선택적인', 즉 값이 '있을 수도,
 없을 수도 있음'을 나타내는 표현입니다.
 즉 변수값이 nil 일수도 있다는 것을 의미합니다.
 스위프트에서는 옵셔널표현 하나만으로 It can be NULL 이나 It can NOT be NULL 을 알수 있다. ]
 또한 옵셔널과 옵셔널이 아닌 값은 철저하게 다른 타입으로 인식한다.
 */



/// 8-1 오류가 발생하는 nil 할당

/*
 
 var myName: String = "yagom"
 myName = nil 오류
 
 */

/*
 nil은 옵셔널로 선언된 곳에서만 사용될 수 있습니다.
 옵셔널 변수 또는 상수 등은 데이터 파입뒤에 물음표(?)를 붙여 표현해 줍니다.
 */



/// 8-2 옵셔널 변수의 선언 및 nil 할당

/*
var myName: String? = "yagom"

print(myName)   // yagom

myName = nil
print(myName)   //nil
 
 */

//var myName: Optional<String> 처럼 표현할 수도 있습니다.



/*

/// 4-19 코드와 옵셔널

let primary = School(rawValue: "유치원" )    //Primary
let graduate = School(rawValue: "석박사" ) //nil
 
let one = Numbers(rawValue: 1) //One
let three = Numbers(rawValue: 3)   //nil

자세히 살펴보면 primary = School(rawValue: "유치원" )은 자동으로 타입추론을 해 주었다. 
석박사나, 3같은 경우에 nil이라는 값이 올수도 있기 때문에 타입은 School? 일 것이다.
 
옵셔널은 열거형으로 구현되어있다.
 
*/



/// 8-3 옵셔널 열거형의 정의

/*
public enum Optional<Wrapped> : ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
    
    public init(_ some: Wrapped)
    /// 중략...
}
 
 옵셔널은 제네릭이 적용된 열거형임을 확인할 수 있고 ExpressibleByNillLiteral 프로토콜을 따르고 있다.
 여기서 볼것은 옵셔널이 값을 갖는 캐이스와 그렇지 못한 케이스 두가지로 정의되어 있다는 것입니다. 
 
 nil일때는 none 케이스가 될것이고 값이 있는 경우는 some 케이스가 되는데 연관값으록 Wrapped에 값이 할당되어 
 있는것을 확인할 수 있습니다. 옵셔널에서 값을 가지면 some의 연관값인 Wrapped에 값이 할당됩니다. 즉, 값이 
 옵셔널이라는 열거형의 방패막에 보호되어 Wrapped되어 있는 모습이라는 겁니다. 
 
 옵셔널 자체가 열거형이기 때문에 옵셔널 변수는 switch 구문을 통해 값이 있고 없음을 확인할수 있습니다.
 
*/



/// 8-4 switc를 통한 옵셔널 값의 확인

func checkOptionalValue(value optionalValue: Any?) {
    switch optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value):
        print("Value is \(value)")
    }
}

/*
var myName: String? = "yagom"

checkOptionalValue(value: myName)   //Value is yagom

myName = nil

checkOptionalValue(value: myName)   //This Optional variable is nil
*/


/// 8-5 switch를 통한 옵셔널 값의 확인 

let numbers: [Int?] = [2,nil,-4,nil,100]

for number in numbers {
    switch number {
    case .some(let value) where value < 0:
        print("Negative value!! \(value)")
        
    case .some(let value) where value > 10:
        print("Large value! \(value)")
        
    case .some(let value):
        print("Value \(value)")
        
    case .none:
        print("nil")
    }
}

/*
    
 열거형의 some 케이스로 꼭꼭 숨은 옵셔널의 값을 옵셔널이 아닌 값으로 추출하는 옵셔널 추출방법
 
 (!)를 붙여서 강제로 값을 추출하는 것이지만 런타임 오류 가능성을 내포하고 있기 때문에 옵셔널 강제 추출 방식은 
 사용을 지양합니다.
 
 */



/// 8-6 옵셔널 값의 강제 추출

var myName: String? = "yagom"
var yagom: String = myName!     //옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없습니다.
//추출해서 할당해주어야 합니다.

myName = nil
//yagom = myName!     런타임 오류! ( nil을 할당할수 없기 떄문에 )

//if 구문 등 조건문을 이용해서 조금 더 안전하게 처리해볼 수 있습니다.
if myName != nil {
    print("My name is \(myName)")
} else {
    print("myName == nil")
}

//myName == nil



/*
 
 옵셔널 바인딩 
 옵셔널 바인딩은 옵셔널에 값이 있는지 확인하 때 사용합니다.
 만약 옵셔널에 값이 있다면 옵셔널에서 추출된 값을 일정 블록 안에서 사용할 수 있는 상수나 변수로 할당해서 옵셔널이 아닌
 형태로 사용할수 있도록 해줍니다. 옵셔널 바인딩은 if 또는 while 구문등과 결합하여 사용할 수 있습니다.
 
 */



/// 8-7 옵셔널 바인딩을 사용한 옵셔널 값의 추출 

//var myName: String? = "yagom"
myName = "yagom"

//옵셔널 바인딩을 통한 임시 상수 할당

if let name = myName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}

//My name is yagom

//옵셔널 바인딩을 통한 임시 변수 할당
if var name = myName {
    name = "wizplan"    //변수이므로 내부에서 변경이 가능합니다.
    print("My name is \(name)")
} else {
    print("myName == nil")
}

//My name is wizplan



/*
 옵셔널 타입만 옵셔널 바인딩을 사용할수 있다. if 블록 안에서만 변수를 사용할수 있다.
var yourName: String = "yagom"

if let name = yourName {
    print("My name is \(name)")
}else {
    print("myName == nil")
}
*/



/// 8-8 옵셔날 바인딩을 사용한 여러 개의 옵셔널 값의 추출 

myName = "yagom"
var yourName: String? = nil

//friend에 바인딩 되지 않으므로 실행되지 않습니다.
if let name = myName, let friend = yourName {
    print("We are friend!")
}

yourName = "eric"

if let name = myName, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}
//We are friend! yagom & eric

/*
    쉼표(,)를 사용해 바인딩 할 옵셔널을 나열하면 됩니다. 단 바인딩하려는 옵셔널 중 하나라도 값이 없다면 
    해당 블록 내부의 명령문의 실행되지 않습니다. 
 
    옵셔널 바인딩은 옵셔널 체이닝과 환상의 결합을 이룹니다. 
    옵셔널 체이닝!!
 */



/*
    암시적 추출 옵셔널
     때때로 nil을 할당하고 싶지만, 옵셔널 바인딩으로 매벌 값을 추출하기 귀찮거나 로직상으로 nil 때문에
    런타임 오류가 발생하지 않을 것 같다는 확신이 들 때 nil을 할당해줄 수 있는 옵셔널이 아닌 변수나 상수가 
    있으면 좋을 겁니다. 
     이때 사용하는 것이 암시적 추출 옵셔널(implicitly Unwrapped Optionals)입니다. 
    옵셔널 = (?)
    암시적 옵셔널 = (!)
    
    암시적 옵셔널에 nil이 할당되어 있을 때 접근을 시도하면 런타임 오류가 발생합니다.
 */

/// 8-9 암시적 추출 옵셔널의 사용

var meName: String! = "yagom"

print(meName)   //yagom

meName = nil

//암시적 추출 옵셔널도 옵셔널이므로 당연히 바인딩을 사용할 수 있습니다.
if var name = meName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}
//myName == nil

//meName라는 암시적 추출 옵셔널에 nil값이 들어가 있기 때문에 문제가 발생하였다.
//print(meName)   오류!!

/*
    옵셔널을 사용할 떄는 강제 추출 또는 암시적 추출 옵셔널을 사용하기보다는 옵셔널 바인딩, nil
    병합 연산자를 비롯해 뒤에서 배울 옵셔널 체이닝 등의 방법을 사용하는 편이 훨씬 안전합니다. 
    또한 이렇게 하는 편이 스위프트의 지향점에 부합합니다. 
 */


