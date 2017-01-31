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











