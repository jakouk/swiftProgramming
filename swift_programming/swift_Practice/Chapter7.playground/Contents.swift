//: Playground - noun: a place where people can play

import UIKit

/// Chapter7. 함수 

/*
    하나의 프로그램은 하나의 큰 함수다.
    스위프트에서 함수는 일급 객체이기 떄문에 하나의 값으로도 사용할 수 있습니다. 
 
    스위프트에서 함수는 다른 언어보다 훨씬 다양한 모습으로 존재하며, 코딩 스타일도 여러 가지 입니다. 
 
    함수와 메서드는 기본적으로 같지만 상황이나 위치에 따라서 다른 용어로 부르는 것뿐입니다. 
    구조체, 클래스, 열거형 등 특정 타입에 연관되어 사용하는 함수를 메서드, 
    모듈 전체에서 전역적으로 사용할 수 있는 참수를 스냥 함수라고 부릅니다. 
 
    스위프트에서의 함수에서는 소괄호 () 를 생략할수 없습니다. 
    스위프트의 함수는 재정의 ( 오버라이드 ), 중복 정의 ( 오버로드 )를 모두 지원합니다. 
 
    스위프트의 함수는 자유도가 굉장히 높은 문법 중 하나입니다.
    기본적으로 함수의 이름과 매개변수, 반환 타입등을 사용하여 함수를 정의합니다.
 
    func 함수 이름(매개변수...) -> 반환 타입 {
        실행 구문
        return 반환 값
 
    }
 
 */



/// 7-1 기본 형태의 함수 정의와 사용

func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)



/// 7-2 매개변수가 없는 함수 정의와 사용

func helloWorld() -> String {
    return "Hello, world!"
}

print(helloWorld())



/// 7-3 매개변수가 여러 개인 함수의 정의와 사용

func sayHello(myName: String, yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}

print(sayHello(myName: "yagom", yourName: "Jenny"))



/*
    전달인자 레이블 
    
    func 함수 이름 (매개변수이름 전달인자레이블 : 매개변수 타입, 매개변수이름 전달인자레이블 : 매개변수 타입...) -> 반환타입 {
    실행구문
    return 반환 값
 }
 
    objective-c 에서 - (void)hello:(NSString *)name yourAge:(NSInteger)age;
    에서 yourAge와 age의 느낌이라고 생각하면 될거 같다.
 
 */



/// 7-4 매개변수 이름과 전달인자 레이블을 가지는 함수 정의와 사용

    //from 과 to 라는 매개변수 이름을 가지며
    //myName과 name으로 전달인자 레이블을 가지는 sayHello함수 

//재정의라서 오류가 나지 않음
func sayHello(from myName: String, to name:String) -> String {
    return "Hello \(name)! I'm \(myName)"
}

print(sayHello(from: "yagom", to: "Jenny"))



/// 7-5 매개변수 이름이 없는 함수 정의와 사용

/*
    매개변수 이름에 와일드카드를 쓰면 매개변수 이름이 없는 함수가 된다.
 */

func sayHello(_ name : String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0 ..< times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Chope", 2)) //Hello Chope! Hello Chope!



/// 7-6 매개변수 이름 변경을 통한 함수 중복 정의 

/*
    함수의 이름은 같지만 매개변수의 이름이 달라서 중복정의 ( 오버로드 ) 가 되었다. 
    위쪽의 sayHello도 모두 중복정의 된것이다.
 */

func sayHello(to name: String, _ times: Int ) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    return result
}

func sayHello(to name: String, repeatCount times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello(to: "Chope",2))
print(sayHello(to: "Chope", repeatCount: 2))



/// 7-7 매개변수 기본값이 있는 함수의 정의와 사용

//times 매개변수가 기본값 3을 갖습니다. 
//함수이름과 매개변수 이름이 다 똑같아도 기본값이 있는 함수와 없는 함수는 다른 함수이다.

func sayHello( _ name: String, times: Int = 3) -> String {
    
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

//times 매개변수의 전달 값을 넘겨주지 않아 기본값 3을 반영해서 세 번 출력합니다.
print(sayHello("Hana"))

//times 매개변수의 전달 값을 2로 넘겨주었기 때문에 전달 값을 반영해서 두 번 출력합니다.
print(sayHello("Joe", times: 2))

//기본값이 없는 매개변수를 기본값이 있는 함수보다 앞에 사용하는것이 좋다. 기본값이 없는 매개변수가 더 중요한 값일수 있다. 



/*
 
    public func pirnt( _ items:Swift.Any ... , separator: String = default, terminator: String = default)로 정의 되어있다.
    terminator의 기본값은 \n인 줄바꿈으로 되어있다.
    separator는 items 매개변수를 통해 들어온 값을 분리해서 표시해주는 문자열을 뜻한다. 기본으로 공백(띄어쓰기)으로 동작합니다.
 
 */



/// 7-8 가변 매개변수를 가지는 함수의 정의와 사용

func sayHelloToFriends(me: String, friends names: String...) -> String {
    
    var result: String = ""
    
    for friend in names {
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm yagom!"
    
    return result
}

print(sayHelloToFriends(me: "yagom", friends: "Johansson","Jay","Wizplan"))
//Hello Johansson! Hello Jay! Hello Wizplan! I'm yagom!

print(sayHelloToFriends(me: "yagom"))
//I'm yagom!



/*
    함수의 전달인자로 값을 전달할 때에는 보통 값을 복사해서 전달합니다.
    하지만 값이 아닌 참조를 전달하려면 입출력 매개변수를 사용합니다. 값 타입 데이터의 참조를 전달인자로 보내면 함수 내부에서
    참조하여 원래 값을 변경합니다. C언어의 포인터와 유사합니다. 
 
    함수형 프로그래밍 패러다임에서 참조는 지양하는 패턴입니다.
 */



/// 7-9 inout 매개변수의 활용

// _ arr 의 의미는 매개변수의 이름은 없고 전달인자가 arr이라는 뜻이다.
var numbers: [Int] = [1, 2, 3]

func nonReferenceParameter( _ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter( _ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)  //복사된 값을 넘겨줌
print(numbers[1])

referenceParameter(&numbers)    //참조를 표현하기 위해 &를 붙여줍니다. ( &numbers는 주소값을 넘겨줌 )
print(numbers[1])

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

var yagom: Person = Person()

//참조 타입의 inout 매개변수 사용은 더욱 주의해야 합니다.
//C언어의 이중 포인터와 유사하게 동작합니다. 

func reference( _ person: inout Person) {
    person.height = 130 // 이렇게 사용하면 기존 참조 매개변수처럼 동작하지만
    print(yagom.height) //130
    person = Person()   //이렇게 다른 인스턴스를 항당하면 참조 자체가 변경되어버립니다.
}

reference(&yagom)
print(yagom.height)
// 0 - 함수 안에서 새로운 인스턴스가 할당 되었기 떄문에 위의 yagom과 다른 참조를 갖습니다.

// 입출력 매개변수는 매개변수 기본값을 가질 수 없으며, 가변 매개변수로 사용될 수 없습니다.
// 또한, 상수는 변경될수 없으므로 입출력 매개변수의 전달인자로 사용될 수 없습니다.



/// 7-10 반환 값이 없는 함수의 정의와 사용

func sayHelloWorld() {
    print("Hello, world")
}

sayHelloWorld()  //Hello, world

/*
func sayHello(from myName: String, to name: String) {
    print("Hello \(name)! I'm \(myName)")
}
 
sayHello(from: "yagom", to: "Mijeong")  //Hello Mijeong! I'm yagom
*/




func sayGoodbye() -> Void {
    print("Good bye")
}
sayGoodbye()



/*
    스위프트의 함수는 일급객체이므로 하나의 데이터 타입으로 사용될 수 있습니다.
    각 함수의 매개변수 타입과 반환 타입으로 구성된 하나의 타입으로 사용(정의) 될수 있습니다.
 
    (매개변수 타입의 나열) -> 반환 타입 
 
    func sayHello(name: String, times: Int) -> String {
        //  ...
    }
 
    sayHello 함수의 함수 타입이 (String, Int) -> String 이라고 표현됩니다.
 
    func sayHelloToFriends(me: String, name: String...) -> String {
        // ...
    }
 
    sayHelloToFriends 함수의 함수 타입은 (String, String...) -> String 이라고 표현됩니다. 
 
    func syHelloWorld() {
    // ...
    }
 
    위의 sayHelloWorld 함수는 (Void) -> Void 라고 표현해 줍니다.
    (Void) -> Void , () -> Void, () -> ()
 
    함수의 축약 표현
 
    sayHello(name: String, times: Int) -> String
    을 sayHello(name:times:)와 같이 이름과 매개변수 개수 등을 표현하여 함수를 표현할수도 있습니다.
 
 
 */


/// 7-11 함수 타입의 사용

typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts( _ a: Int, _ b :Int) -> Int {
    return a + b
}

func multiplyTwoInts( _ a: Int, _ b:Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
//var mathFunction: (Int, Int) -> Int = addTwoInts와 동일한 표현입니다.

print(mathFunction(2,5))    // 2+5 = 7

mathFunction = multiplyTwoInts;

print(mathFunction(2,5))    //2*5 = 10


/*
    mathFunction: 의 타입이 CalculateTwoInts라는 것이고 그것이 addTwoInts라는 함수라는 것이다.
 
    typealias Age: Int
    let number: Int = 1
    var myAge: Age = number
 
    의 느낌과 비슷한것 같다.
 */



/// 7-12 전달인자로 함수를 전달받는 함수 

func printMathResult( _ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a,b))")
}

printMathResult(addTwoInts, 3, 5)

/*
    CalculateTwoInts라는 타입 이른바 addTwoInts가 CalculateTwoInts의 타입과 같이 때문에 함수 자체를 넘길수 있다.
 */



/// 7-13 특정 조건에 따라 적절한 함수를 반환해 주는 함수

func chooseMathFunction( _ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)     //Result: 8

/*
    반환값이 CalculateTwoInt 이기 때문에 printMathResult에 chooseMathFuction을 넣을수 있다.\
 
    스위프트의 함수는 일급객체이기 때문에 C언어에서는 포인터를 사용해야했고 그러인해 발생하는 다양한 문제점이 있었습니다.
    일급객체가 아닌 기존 언어의 함수와 스위프트함수와의 차이가 무엇인지, 어떤 점이 더 좋은지 생각할 필요가 있습니다.
*/



/*
    스위프트는 데이터 타입의 중첩에 자유롭다. 열거형안에 또 하나의 열거형이 들어갈수 있고 클래스안에 또 다른 클래스가
    들어갈수 있고 함수안에 또 하나의 함수를 넣을수도 있다. 
    우리가 앞에서 만든 함수는 모두 전역함수이기 때문에 모듈 어디서든 사용될수 있는 함수라는 뜻입니다. 
    그러나 함수 안에 함수로 구현된 중첩함수는 상위 함수의 몸통 블록내부에서만 사용할수 있습니다. 
    물론 중첩 함수의 사용범위가 해당 함수 안쪽이라고 해서 아예 외부에서 사용할 수 없는 것은 아닙니다.
    함수가 하나의 반환값으로 사용될 수 있으므로 중첩함수를 담고 있는 함수가 중첩함수를 반환하면 밖에서도 사용할 수 있습니다.
 */



/// 7-14 원점으로 이동하기 위한 함수


typealias MoveFunc = (Int) -> Int

/*
func goRight(_ currentPosition: Int) -> Int {
    return currentPosition + 1
}

func goLeft(_ currentPosition: Int) -> Int {
    return currentPosition - 1
}

func functionForMove( _ shouldGoLeft: Bool) -> MoveFunc {
    return shouldGoLeft ? goLeft : goRight
}

var position: Int = 3  // 현위치
let moveToZero: MoveFunc = functionForMove(position > 0)    // 스위프트는 연산자의 띄어쓰기가 중요하다.
// 현위치가 0보다 크므로 전달되는 인자 값은 true가 됩니다.
// 그러므로 goLeft( _:) 함수가 할당될 것입니다.

print("원점으로 갑시다.")

while position != 0 {    // 원점에 도착하면(현위치가 0이면) 반복문이 종료됩니다.
    print("\(position)...")
    position = moveToZero(position)
}
print("원점 도착!")
*/



/// 7-15 중첩 함수의 사용

func functionForMove( _ shouldFoLeft: Bool) -> MoveFunc {
    func goRight( _ currentPosition: Int) -> Int {
        return currentPosition + 1
    }
    
    func goLeft( _ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldFoLeft ? goLeft : goRight
}

var position: Int = -4  //현위치

let moveToZero: MoveFunc = functionForMove(position > 0)
// 현위치가 0보다 작으므로 전달되는 인자 값은 false가 됩니다.
// 그러므로 goRight(_:) 함수가 할당될것입니다.

while position != 0 {
    print("\(position)...")
    position = moveToZero(position)
}
print("원점 도착")



/*
    스위프트에는 종료되지 않는 함수가 있습니다.
    비반환 함수가 호출되면 다음코드는 실행되지 않기때문에 프로세스 동작이 끝났다고 볼수 있습니다.
    그 이유는 비반환 함수 안에서는 오류는 던진다던지, 중대한 시스템 오류를 보고하는 등의 일을 하고 
    프로세스를 종료해 버리기 때문입니다. 
 
    비반환 함수는 어디서든 호출이 가능하고 guard 구문의 else 블록에서도 호출할 수 있습니다.
    비반환 메서드는 재정의는 할 수 있지만 비반환 타입이라는 것은 변경할 수 없습니다.
 */


/// 7-16 비반환 함수의 정의와 사용

func crashAndBurn() -> Never {
    fatalError("Something very, very bad happen")
}

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다.")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true) // All is well
someFunction(isAllIsWell: false)    // 마을에 도둑이 들었습니다.!
//프로세스 종료 후 오류 보고











