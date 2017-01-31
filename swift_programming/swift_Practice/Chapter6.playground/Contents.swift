//: Playground - noun: a place where people can play

import UIKit

/// Chapter6. 흐름 제어

/*
    스위프트의 if 구문은 조건의 값이 꼭 Bool 타입이어야 합니다.
 */

/// 6-1 if 구문 기본 구현

/*
let first: Int = 5
let second: Int = 7

if first > second {
    print("first > second")
} else if first < second {
    print("fisrt < second")
} else {
    print("first == second")
}
*/

//결과는 first < second 가 출력 됩니다. 



/// 6-2-1 if 구문의 다양한 구현(소관호가 없는 코드)

/*
let first: Int = 5
let second: Int = 5
var biggerValue: Int = 0

if first > second { //조건 수식을 소괄호로 묶어주는 것은 선택 사항입니다.
    biggerValue = first
} else if first == second {
    biggerValue = second
} else if first == 5 {
    
    //조건이 충족하더라도 이미 first == second라는 조건이 충족되어 위에서 실행되었기때문에 실행되지 않습니다.
    
    biggerValue = 100
}
//마지막 else는 생략 가능합니다. 물론 else if도 생략 가능합니다.
//즉, else나 else if 없이 if만 단독으로 사용할 수도 있습니다.

print(biggerValue)
*/



/// 6-2-2 if 구문의 다양한 구현(소괄호가 있는 코드)

let first: Int = 5
let second: Int = 5
var biggerValue: Int = 0

if (first > second) {   //조건 수식을 소괄호로 무꺼주는 것은 선택 사항입니다.
    biggerValue = first
} else if ( first < second ) {
    biggerValue = second
} else if ( first == 5 ) {
    //조건이 충족되더라고 이미 first == second라는 조건이 충족되어 위에서 실행되었기 때문에 실행되지 않습니다.
    biggerValue = 100
}

//마지막 else는 생략이 가능합니다. 물론 else if도 생략 가능합니다.
//즉, else나 else if 없이 if만 단독으로 사용할 수도 있습니다. 

print(biggerValue)  //5



/*
 
    스위프트의 switch구문은 다른 언어에 비해 많이 달라진 문법중 하나입니다. 
    switch구문도 소괄호를 생략할수 있습니다. 단 break 키워드는 선택사항입니다.
 
    즉 break없이도 switch구문이 종료된다는 뜻이 됩니다. 
    스위프트에서 switch 구문의 case를 연속 실행하려면 fallthrogh 키워드를 사용하면 됩니다. 
    C언어에서는 정수형만 들어갈수 있었으나 스위프트는 다양한 값이 들어갈수 있지만 데이터 타입은 같아야합니다. 
 
    또 비교될 값이 명확히 한정적인 값이(열거형 값등)이 아닐때는 default를 꼭 작성해야 합니다. 
 
    또한 각case에는 범위 연산자가 사용될수도 where절을 사용하여 조건을 확장할 수도 있습니다.
 
 
 */

/*
 switch 입력 값 {
 
 case 비교 값 1:
    실행 구문
 case 비교 값 2:
    실행 구문
    fallthrough 
 
    //이번 케이스를 마치고 switch 구문을 탈출하지 않습니다.
    //아래 case로 넘어갑니다
 
 
 case 비교 값3, 비교 값4, 비교 값5 : //한 번에 여러 값과 비교될 수 있습니다.
    실행 구문
    break       //break
 default :      //한정된 범위가 명확지 않다면 default 케이스는 필수 입니다.
    실행 구문
 
 }
 */



/// 6-3 switch 구문 기본 구현

let integerValue: Int = 5

switch integerValue {
case 0:
    print("Value == zero")
case 1 ... 10:
    print("Value == 1 ~ 10")
    fallthrough
case Int.min ..< 0 , 101 ..< Int.max:
    print("Value < 0 or Vlaue > 100")
    break
default:
    print("10 < Value <= 100")
}

//결과 
//Value == 1~10
//Value < 0 or Value > 100



/// 6-4 부동소수 타입의 범위 연산을 통한 switch case 구성

let doubleValue: Double = 3.0

switch doubleValue {
case 0:
    print("Value == zero")
case 1.5 ... 10.5:
    print("1.5 <= Value <= 10.5")
default:
    print("Value == \(doubleValue)")
}

//결과 
//1.5 <= Value <= 10.5



/// 6-5 문자열 switch case 구성

/*
let stringValue: String = "Liam Neeson"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny", "Joker", "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know no who you are' ")
}

//Liam Neeson said 'I don't know who you ara'
*/


/// 6-6 잘못된 case 사용

/*
let stringValue: String = "Liam Neeson"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny":
    // stringValue가 "Jenny"에 해당될 때 실행될 코드가 와야합니다.
    // 비어있으므로 오류 발생!
case "Joker"
    // stringValue가 "Joker"에 해당될 때 실행될 코드가 와야합니다.
    // 비어있으므로 오류 발생!
case "Nova":
    print("He or She is \(stringValue)" )
default:
    print("\(stringValue) said 'I don't know who you are'")
}
*/
 

/// 6-7 fallthrough 의 사용
 
let stringValue: String = "Joker"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")

case "Jenny":
    fallthrough
case "Joker":
    fallthrough
case "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are'")
}

// He or She is Joker



/// 6-8 튜플 switch case 구성

/*
typealias NameAge = (name: String, age : Int)

let tupleValue: NameAge = ("yagom",99)

switch tupleValue {
case ("yagom",99):
    print("정확히 맞추셨습니다.!")
default:
    print("누구를 찾으시나요?")
}

//정확히 맞추셨습니다.
*/


/// 6-9 와일드카드 식별자를 사용한 튜플 switch case 구성

/*
    (_)와일드 카드 식별자이다. ( 아무값 이라는 의미인것 같다. )
 */

/*
typealias NameAge = (name: String, age : Int)

let tupleValue: NameAge = ("yagom",99)

switch tupleValue {
case ("yagom", 50):
    print("정확히 맞추셨습니다.")
case ("yagom", _):
    print("이름만 맞았습니다. 나이는 \(tupleValue.age)입니다.")
case (_,99):
    print("나이만 맞았습니다. 이름은 \(tupleValue.name)")
default:
    print("누구를 찾으시나요?")
}

//이름만 맞았습니다. 나이는 99입니다.
*/


/// 6-10 값 바인딩을 사용한 튜플 switch case 구성

typealias NameAge = (name: String, age: Int)

let tupleValue: NameAge = ("yagom",99)

switch tupleValue {
case ("yagom", 50):
    print("정확히 맞추셨습니다!")
case ("yagom", let age):
    print("이름만 맞았습니다. 나이는 \(age)입니다")
case(let name, 99):
    print("나이만 맞았습니다. 이름은 \(name)입니다")
default:
    print("누굴 찾으시나요?")
}

//이름만 맞았습니다. 나이는 99입니다.



/// 6- 11 where를 사용하여 switch case 확장

/*
 wherer 절을 사용하여 조건문을 더 줄수 있다.
 */

let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다")
case "사원" where 연차 > 5:
    print("연식 좀 된 사원입니다.")
case "사원":
    print("사원입니다")
case "대리":
    print("대리입니다")
default:
    print("사장입니까?")
}

//신입사원입니다.



/// 6- 12 열거형을 입력 값으로 받는 switch 구문 

enum School {
    case primary, elementary, middle, high, college, university, graduate
}

let 최종학력: School = School.university

switch 최종학력 {
case .primary:
    print("최종학력은 유치원입니다.")
case .elementary:
    print("최종학력은 초등학교입니다.")
case .middle:
    print("최종학력은 중학교입니다")
case .high:
    print("최종학력은 고등학교입니다")
case .college, .university:
    print("최종학력은 대학(교)입니다")
case .graduate:
    print("최종학력은 대학원입니다.")
}

//최종학력은 대학 (교) 입니다.



/* 
    반복문 
 
    C언어 방식이던 for( ...; ... ; ... ; )이 스위프트3.0부터 사라졌습니다.
    for - in 구문
 
    for 임시 상수 in 시퀀스 아이템 {
        실행 코드
    }
 
 */

/// 6-13 for-in 반복 구문의 활용

for i in 0...2 {
    print(i)
}

// 0 , 1, 2 

for i in 0...5 {
    if i % 2 == 0 {
        print(i)
        continue    //continue 키워드를 사용하면 바로 다른 시퀀스로 건너뜁니다.
    }
    print("\(i) == 홀수")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift.characters {
    print(char)
}

var result: Int = 1

//시퀀스에 해당하는 값이 팔요 없다면 와일드카드 식별자(_)를 사용하면 됩니다.

for _ in 1 ... 3 {
    result *= 10
}

print("10의 3제곱은 \(result)입니다")

// 10의 3제곱은 1000입니다.



/// 6-14 기본 데이터 타입의 for - in 반복 구문 사용

// Dictionary
// 딕셔너리의 기본 반환값은 튜플이다.
// 딕셔너리는 순서를 보장하지 않는다.

let friends: [String: Int] = ["Jay":35, "Joe":29, "Jenny":31]

for tuple in friends {
    print(tuple)
}

let 주소 :[String: String] = ["도":"충청북도", "시군구":"청주시 청원구","동읍면":"율량동"]

for (키, 값) in 주소 {
    print("\(키) : \(값)")
}

//Set 

let 지역번호 : Set<String> = ["02,","031","032","033","041","042","043","051","052","053","054","055","061","062","063","064"]

for 번호 in 지역번호 {
    print(번호)
}



/// 6-15 while 반복 구문의 사용

/*
    while 뒤에 ()는 생략이 가능하다. 
    while문의 조건이 참이면 계속해서 돈다.
 */

/*
var names: [String] = ["Joker", "Jenny", "Nova", "yagom"]

while (names.isEmpty == false) {
    print("Good bye \(names.removeFirst())")
    // removeFirst()는 요소를 삭제함과 동시에 삭제된 요소를 반환합니다.
}
*/


/// 6-16 repeat-while 반복 구문의 사용 


// 다른 언어의 do - while 문과 같은 역활을 한다.
var names: [String] = ["John", "Jenny",  "Joe", "yagom"]

repeat {
    print("Good bye \(names.removeFirst())")
    //removeFirst()는 요소를 삭제함과 동시에 삭제된 요소를 반환합니다.
}while names.isEmpty == false



/// 6-17 중첩된 반복문의 구문 이름표 사용

/*
    countinue를 만나면 바로 다음 시퀀스로 이동 1 이면 2로 < 아래구문은 3 -> 2342
 */

var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
    printLoop: while true {
        print(num)
        count += 1
        
        if count == num {
            break printLoop
        }
    }
    
    removeLoop: while true {
        if numbers.first != num {
            break numbersLoop
        }
        numbers.removeFirst()
    }
}

// 3
// 3
// 3
// numbers에는 [2342, 6, 3252]가 남습니다.




