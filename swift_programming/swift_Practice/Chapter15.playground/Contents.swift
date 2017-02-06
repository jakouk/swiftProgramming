//: Playground - noun: a place where people can play

import UIKit

/// Chapter15. 맴, 필터, 리듀스

/*
    스위프트는 함수를 일급 객첼 취급합니다. 따라서 함수를 다른 함수의 전달인자로 사용할 수 있습니다. 매개변수로 함수를 갖는 
    함수를 고차함수라고 부르는데, 스위프트에 유용한 대표적 고차함수로는 맵, 필터, 리듀스 등이 있습니다.
 */



/*
    맵은 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수입니다. 스위프트에서 맵은 배열,
    딕셔너리, 세트, 옵셔널 등에서 사용할 수 있습니다. 조금 더 정확히 말하자면 스위프트의 Sequence, Collection 
    프로토콜을 따르는 타입과 옵셔널은 모두 맥을 사용할 수 있습니다. 맵을 사용하면 컨테이너가 담고 있던 각각의 값을 
    매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환합니다. 기존 컨테이너의 값은 변경되지 않고 새로운 
    컨테이너가 생성되어 반환됩니다. 그래서 맵은 기존 데이터를 변형(tranform)하는데 많이 사용됩니다.
 
    container.map(f(x)) 컨테이너의 map 메서드 호출
    
    return f(container의 각 요소) ( 새로운 요소 )
 
    map 메서드의 사용범은 앞서 알아본 for - in 구문과 변반 차이가 없습니다. 다만, 코드의 재사용 측면이나 컴파일러 최적화
    측면에서 본다면 성능 차이가 있습니다. 또 다중 스레드 환경일 때 대상 컨테이너의 값이 스레드에서 변경되는 시점에 다른 스레드
    에서 동시에 변경되려고 할 때 예측치 못한 결과가 발생하는 부작용을 방지할 수도 있습니다.
 */

/// 15-1 for-in 구문과 맵 메서드의 사용 비교

let numbers: [Int] = [0,1,2,3,4]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// for 구문 사용
for number in numbers {
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)   // [ 0, 2, 4, 6, 8]
print(strings)  // ["0", "1", "2", "3", "4"]

// map 메서드 사용
doubledNumbers = numbers.map({  $0 * 2
})
strings = numbers.map({ "\($0)"
})

print(doubledNumbers)   // [0,2,4,6,8]
print(strings)  // ["0", "1", "2", "3", "4"]



/*
    짧은 코드라 차이를 느끼기는 힘들곘지만 코드를 살펴보면 map 메서드를 사용했을 때 for-in 구문을 상요한 것 보다 간결하고
    편리하게 각 요소의 연산을 수행하는 것을 볼수 있습니다. 심지어 map 메서드를 사용하면 for-in 구문을 사용하기 위하여 
    빈 배열을 처음 생성해주는 작업도 필요도 없습니다. 배열의 append 연산을 수행하기 위한 시간도 필요없습니다.
 */

/// 15-2 클로저 표현의 간략화

let numbers1 : [Int] = [0, 1, 2, 3, 4]

// 기본 클로저 표현식 사용
var doubleNumbers1 = numbers1.map { (number: Int) -> Int in
    return number * 2
}

// 매개변수 및 반환 타입 생략 
doubleNumbers1 = numbers1.map({return $0 * 2})
print(doubleNumbers1)

// 반환 키워드 생략
doubleNumbers1 = numbers1.map({$0 * 2})
print(doubleNumbers1)

// 후행 클로저 사용
doubleNumbers1 = numbers1.map {$0 * 2}
print(doubleNumbers1)



/// 15-3 클로저의 반복 사용

let evenNumbers: [Int] = [0, 2, 4, 6, 8]
let oddNumbers: [Int] = [0, 1, 3, 5, 7]
let multiplyTwo : (Int) -> Int = { $0 * 2 } // just Closure

let doubledEvenNumbers = evenNumbers.map(multiplyTwo)
print(doubledEvenNumbers)

let doubledOddNumbers = oddNumbers.map(multiplyTwo)
print(doubledOddNumbers)



/// 15-4 다양한 컨테이너 타입에서의 맵의 활용

let alphabetDictionary: [String : String] = ["a":"A", "b":"B"]

var keys: [String] = alphabetDictionary.map {(tuple: (String, String)) -> String in
        return tuple.0
}

keys = alphabetDictionary.map{$0.0}

let value: [String] = alphabetDictionary.map { $0.1 }
print(keys) // ["b", "a"]
print(value) // ["B", "A"]

var numberSet: Set<Int> = [1, 2, 3, 4, 5]
let resultSet = numberSet.map{$0 * 2}
print(resultSet)    // [2, 4, 6, 8, 10]

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map { $0 * 2}
print(resultInt)    // 6

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map { $0 * 2}
print(resultRange)  // [ 0, 2, 4, 6]



/*
    필터
 
    필터는 말 그대로, 컨테이너 내부의 값을 걸러서 추출하는 역활을 하는 고차 함수입니다. 맵과 마찬가지로 새로운 컨테이너에 값을
    담아 반환해 줍니다. 다만 맵처럼 기존 콘테츠를 변형하는 것이 아니라, 기존 콘테츠를 특정 조건에 맞게 걸러내는 역활을 할 수
    있다는 점이 다릅니다. filter 함수의 매개변수로 전달되는 함수의 반환 타입은 Bool입니다. 해당 콘테츠의 값을 가지고 새로운
    컨테이너에 포함될 항목이라고 판단되면 true를, 포함하지 않으려면 false를 반환해주면 됩니다.
 */



/// 15-5 필터 메서드의 사용

let numbers2: [Int] = [0, 1, 2, 3, 4, 5]

let evenNumbers2: [Int] = numbers2.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers2) // [ 0, 2, 4]

let oddNumbers2: [Int] = numbers2.filter { $0 % 2 != 0 }
print(oddNumbers2)



/// 15-6 맵과 필터 메서드의 연계 사용

let numbers3: [Int] = [0, 1, 2, 3, 4, 5]

let mappedNumbers3: [Int] = numbers3.map{ $0 + 3 }

let evenNumbers3: [Int] = mappedNumbers3.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers3)  // [ 4, 6, 8]

// mappedNumbers가 굳이 여러 번 사용될 필요가 없다면 메서드를 체인처럼 연결하여 사용할 수 있습니다.
let oddNumbers3: [Int] = numbers3.map{ $0 + 3}.filter{ $0 % 2 != 0 }
print(oddNumbers3)  // [ 3, 5, 7]



/*
    리듀스
    리듀스 기능은 사실 Combine이라고 불려야 마땅한 기능입니다. 리듀스는 컨테이너 내부의 콘테츠를 하나로 합쳐주는 기능을 
    수행하는 고차함수입니다. 정수 배열이라면 저수 배열의 모든 값을 전달 인자로 전달 받은 함수의 연산 결과로 합쳐주고, 문자열
    배열이라면 문자열을 하나로 합쳐줍니다. initial 이라는 이름의 매개변수로 전달되는 값을 통해 초깃값을 지정해줄수 있습니다.
 
    !!! 내가 이해한 내용
    리듀스는 $0, $1 이 존재한다. $0 은 내가 입력해 주는 값이고 $1 은 리스트등과 같은 것이다.
 */



/// 15-7 리듀스 메서드의 사용

let numbers4: [Int] = [1,2,3]

// 초깃값이 0이고 정수 배열의 모든 값을 더합니다.
var sum: Int = numbers4.reduce(0, { (first: Int, second: Int) -> Int in
    print("\(first) + \(second)")
    return first + second
})

print(sum)  // 6

// 초깃값이 0이고, 정수 배열의 모든 값을 뺍니다.
var subtract: Int = numbers4.reduce(0) { (first: Int, second: Int) -> Int in
    print("\(first) - \(second)")
    return first - second
}

print(subtract) // -6

// 초깃값이 3이고 정수 배열의 모든 값을 더합니다.
let sumFromThree: Int = numbers4.reduce(3) {
    print("\($0) + \($1)")
    return $0 + $1
}

print(sumFromThree) // 9

// 초깃값이 3이고 정수 배열의 모든 값을 뺍니다.
let subtractFromThree: Int = numbers4.reduce(3) {
    print("\($0) - \($1)")
    return $0 - $1
}

print(subtractFromThree)    // -3 

// 문자열 배열을 reduce(_:_:) 메서드를 통해 연결시킵니다.
let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reduceNames: String = names.reduce("yagom's friend : ") {
    return $0 + ", " + $1
}

print(reduceNames)  // yagom's friend : , Chope, Jay, Joke, Nova"



/// 15-8 맵, 필터, 리듀스 메서드의 연계 사용

let numbers5: [Int] = [1,2,3,4,5,6,7]

// 짝수를 걸러내어 각 값에 3을 곱해준 후 모든 값을 더합니다.

var result : Int = numbers5.filter{ $0 % 2 == 0}.map{ $0 * 3 }.reduce(0){ $0 + $1 }
print(result)   // 36

// for-in 구문 사용시
result = 0

for number in numbers5 {
    guard number % 2 == 0 else {
        continue
    }
    result += number * 3
}

print(result)



/// 15-9 친구들의 정보 생성

enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age : UInt
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JunHyun", gender: .female, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .male, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 29))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))



/// 15-10 조건에 맞는 친구 결과 출력

let list: [Friend] = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }

let outSeoul : [Friend] = list.filter{ $0.location != "서울" && $0.age >= 25 }

let string: String = outSeoul.reduce("서울 외의 지역에 거주하고 25세 이상인 사람들은 ") { $0 + " \n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세" }

print(string)

/*
    참 좋은 예제인것 같다. 한번더 고민해 보면서 만들면 좋을것 같다.
 */







