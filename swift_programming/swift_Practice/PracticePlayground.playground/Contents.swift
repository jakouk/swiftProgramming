//: Playground - noun: a place where people can play

import UIKit



let hello :String = ({() -> String in
    var hello: String = "Hello"
    print("hello")
    return hello
})()

({ (frist :String) -> String in
    print("Hello")
    return frist
})

let names: [String] = ["wizplan","eric","yagom","jenny"]

func backWords(first: String, second: String) -> Bool {
    return first > second
}



let reversed: [String] = names.sorted(by: backWords)

let reverse: [String] = names.sorted { (first, second) -> Bool in
    return first > second
}

let reversed1: [String] = names.sorted {
    return $0 > $1
}

let reversed2: [String] = names.sorted {
    $0 > $1
}

func makeIncrementer(forIncrement amout: Int) -> (() -> Int)  {
    var runningTotal = 0
    
    // Closure 중첩 함수 ( 함수안에 함수가 있으면 Closure 이다 )
    func incremeter() -> Int {
        runningTotal += amout
        return runningTotal
    }
    return incremeter
}


let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo()   // 2
let second: Int = incrementByTwo()  // 4

let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)

let first1: Int = incrementByTwo2()     // 2
let second2: Int = incrementByTwo2()    // 4

let third: Int = incrementByTwo()   // 6
let third1: Int = incrementByTwo2() // 6

/*
    두개의 함수가 다른것 같다.
 
    makeIncrementer의 return이 incrementerByTwo에 저장되는 순간 하나의 Closure가 된다.
 
    makeIncrementer의 return이 icnrementerByTwo2에 저장되는 순간 하나의 Closure가 된다.
 */





// 탈출 클로저란 매개변수로 들어온 클로저가 함수가 끝날때 반환되어야 하는 경우에 escaping 키워드를 사용해야 함을 의미한다.
// 또한 들어온 클로저가 외부에서의 값에 저장되거나 해야할때 탈출 키워드를 써줘야한다.



/*
    자동 클로저
 
    함수의 전달인자로 전달되는 표현을 자동으로 변환해주는 클로저를 자동 클로저라고 합니다.
    자동 클로저는 전달인자를 갖지 않습니다. 자동 클로저는 호출되었을 때 자신이 감싸고 있는 코드의 결괏값을 반환합니다.
    자동 클로저는 함수로 전달되는 클로저를 ( 소괄호와 중괄호를 겹쳐서 써야하는 ) 어려운 클로저 문법을 사용하지 않고도 클로저로
    사용할 수 있도록 문법적 편의를 제공합니다.
 
    스위프트 표준 라이브러리에는 자동 클로저를 호출하는 함수가 구현되어 있어 이를 사용하는 일이 종종 있습니다. 하지마
    직접 자동 클로저를 호출하는 함수를 구현하는 일은 흔치 않을 겂니다. 예를 들어 스위프트 표준 아비르러리에 구현되어 있는
    assert(condition:message:file:line:)함수는 condition과 message 매개변수가 자동 클로저입니다. condition
    매개변수는 디버그용 빌드에서만 실행되고, message 매개변수는 condition 매개변수가 false일 때만 실행됩니다.
 
    자동 클로저는 클로저가 호출되기 전까지는 클로저 내부의 코드는 종작하지 않습니다. 따라서 연산을 지연시킬 수 있습니다.
    이 과정은 연산에 자원이 많이 소모된다거나 부작용이 우려 될때 사용할 수 있습니다. 왜냐하면 코드의 실행을 제어하기 좋기
    때문입니다.
 */

/// 13-19 클로저를 이용한 연산 지연

// 대기 중인 손님입니다.

/*
var customersInLine: [String] = ["YoangWha","SangYoun","SungHun","HaMi"]
print(customersInLine.count)

// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있습니다.
let customerProvider: () -> String = {
    return customersInLine.removeFirst()
}
print(customersInLine.count)

// 실제로 실행합니다.

print("Now serving \(customerProvider())!") // "Now serving YoangWha!"
print(customersInLine.count)
*/

/*
    customerProvider 상수에 저장해둔 클로저는 하나의 명령문 묶음으로 볼 수 있습니다. Array의 removeFirst()
    메서드는 자신의 첫 번째 요소를 제거하면서 그 요소를 반환해주는 메서드였던 것 기억하시나요? 그래서 customerProvider()
    가 선언되었지만 바로 아래서 호출한 print(customerInLine.count) 코드에서는 클로저 내부의 연산이 반영되지 않으며
    클로저가 실제로 실행되기 전까지는 removeFirst() 메서드가 연산되지도 않습니다. 그 뒤에 실제로 클로저를 실행하게 되면
    그때서야 연산을 수행하게 됩니다. 클로저가 영영 호출되지 않는다면 내부의 코드도 실행되지 않기 때문에 해당 연산은 수행되지 
    않습니다. 우리가 이제껏 알고 있던 클로저의 활용과 크게 다르지 않은 내용입니다.
 */

/// 13-20 함수의 전달인자로 전달되는 클로저


var customersInLine: [String] =  ["YoangWha", "SangYoung", "SungHun", "HaMi"]

/*
    기존의 serveCustomer(_:) 함수와 동일한 역활을 수행하지만 매개변수에 @autoclosure 속성을 주었기 때문에 자동
    클로저 기능을 사용합니다. 자동 클로저 속성을 부여한 매개변수는 클로저 대신에 customersInLine.removeFirst() 코드의
    실행 결과인 String 타입의 문자열을 전달인자로 받게 됩니다. String 타입의 값이 자동 클로저 매개변수에 전달되면 String
    값을 매개변수가 없는 String값을 반환하는 를로저가 변환해 줍니다.
 */

/// 13-21 자동 클로저의 사용

// var customersInLine: [String] =  ["YoangWha", "SangYoung", "SungHun", "HaMi"]

// 1 closure
func serveCustomer( _ customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer({ customersInLine.removeFirst() })

serveCustomer { () -> String in
    return "hello"
}


let customerProvider1: (String) -> String = {
    return "hello \($0)"
}

// 2 autoclosure
func serveCustomer1( _ customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

func serveCustom3(_ returnString: String) -> () {
    print(returnString)
}

// 3 autoclosure -> closure
func serveCustomer2( _ customerProvider: () -> String ) -> String{
    return "Now serving \(customerProvider())!"
}

//customerProvider() 은 스트링임 .



serveCustomer({customersInLine.removeFirst()})

// String 타입의 값이 자동 클로저 매개변수에 전달되면 

// 전달받은 String 값을  ->  매개변수가 없는 String값을 반환하는 클로저로 변환해 줍니다.

// 100% 이제는 안됨 ㅠㅠ 
// 어쨋든 자동 클로저를 사용하면 {} 대신에 () 을 사용할수 있음 .



/*
    자동 클로저
 
    자동 클로저를 사용하게 되면 매개변수를 클로저 대신에 코드의 실행결과인 String 타입의 문자열을 전달 인자로 받게 됩니다.
    String 타입의 값이 자동 클로저 매개변수에 전달되면 String 값을 매개변수가 없는 String 값을 반환하는 클로저로 변환
    해줍니다. String 타입의 값을 전달 받는 이유는 자동 클로저의 반환 타입이 String이기 때문입니다. 자동 클로저는 전달인자를
    갖지 않기 때문에 반환 타입의 값이 자동 클로저의 매개변수로 전달되면 이를 클로저로 바꿔줄 수 있는 것입니다. 이렇게 String 
    값으로 전달된 전달인자가 자동으로 클로저로 변환되기 때문에 자동 클로저라고 부릅니다.
 */

/*
    결국 함수형 프로그래밍의 핵심은 함수를 하나의 변수값으로 만들수 있다는것이 아닐까 생각된다.
 */




