//: Playground - noun: a place where people can play

import UIKit

/// Chapter13. 클로저

/*
    스위프트에서 함수형 프로그래밍 패러다임을 접할 때 첫걸음으로 꼭 알아야 할 녀석이 바로 클로저(Closure)입니다.
    클로저를 잘 이해해야 스위프트의 함수형 프로그래밍 패러다임 스타일을 좀 더 명확하게 이해할 수 있습니다. 클로저와
    제네릭(Generics), 프로토콜(Protocol), 모나드(Monad)등이 결합함으로써 스위프트는 훨씬 강력한 언어로 사용됩니다.
 
    스위프트이 클로저는 C 언어나 Objective-C의 블록(Block) 또는 다른 프로그래밍 언어의 람다(Lambda)와 유사한 녀석
    입니다. 클로저는 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것을 말합니다. 뭔가 함수랑 비슷한가요? 사실 함수는
    클로저의 한 형태입니다.
 
    클로저는 변수나 상수가 선언된 위치에서 참조(Reference)를 획득(Capture)하고 저장할 수 있습니다. 이를 변수나 상수의
    클로징(잠금)이라고 하며 클로저는 여기서 착안된 이름입니다. 획득 때문에 메모리에 부담이 가지 않을까 걱정할 수도 있지만,
    앞서 설명했듯이 스위프트는 스스로 메모리관리를 합니다. 
 
    클로저는 세가지 모양을 가질 수 있습니다.
    이름을 가지면서 어떤 값도 획득하지 않는 전역함수의 형태
    이름을 가지면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
    이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성된 형태
 
    클로저는 매개변수와 반환 값의 타입을 문맥을 통해 유추할 수 있기 때문에 매개변수와 반환 값의 타입을 생략 할 수 있습니다.
    클로저에 단 한 줄의 표현만 들어있다면 암시적으로 이를 반환 값으로 취급합니다.
    축약된 전달인자 이름을 사용할 수 있습니다.
    후행 클로저 문법을 사용할 수 있습니다. 
 
    클로저는 기본 클로저와, 후행 클로저의 표현이 있습니다.
 */



/*
    기본 클로저
 
 */

/// 13-1 스위프트 라이브러리의 sorted(by:)메서드 정의

/*
public func sorted(by areInIncreadingOrer: (Element, Element) -> Bool) -> [Element]
*/



/// 13-2 정렬에 사용될 이름 배열

let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

/*
    sorted(by:) 메서드는 (배열의 타입과 같은 두 개의 매개변수를 가지며 Bool 타입을 반환하는 ) 클로저를 전달인자로 
    받을 수 있습니다. 반환하는 Bool 값은 첫 번째 전달인자 값이 새로 생성되는 배열에서 두 번째 전달인자 값보다 먼저 
    배치되어야 하는지에 대한 결괏값입니다. true를 반환하면 첫 번째 전달인자가 두 번째 전달인자보다 앞에 옵니다.
 
    함수를 메서드의 전달인자로 보내는 일은 함수형 프로그래밍 패러다임에서는 아주 달연한 일입니다.
 */



/// 13-3 정렬을 위한 함수 전달

/*
func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교중")
    return first > second
}

let reversed: [String] = names.sorted(by: backwards)
print(reversed) // ["yagom","wizplan","jenny","eric"]
 */

/*
    만약 first 문자열이 second 문자열보다 크다면 backwards(first:second:)함수의 반환 값은 true가 될 것입니다.
    즉, 값이 더 큰 first 문자열이 second 문자열보다 앞쪽에 정렬되어야 한다는 뜻입니다. 그러나 first > second라는 
    반환 값을 받기 위해 너무 많은 표현을 사용했습니다. 예시 코드에서 print 함수는 참고용 콘솔 출력이니 제외해도 역시 
    많습니다. 함수 이름부터 매개변수 표현까지 부가적 표현도 많습니다. 이를 크로저 표현을 사용해서 조금 더 간결하게 표현
    하겠습니다. 
 
    클로저 표현은 통상 아래 형식을 따릅니다.
    { (매개변수) -> 반환 타입 in
        실행코드
    }
 
    클로저도 함수와 마찬가지로 입출력 매개변수를 사용할 수 있습니다. 매개변수 이름을 지정한다면 가변 매개변수 또한 
    사용가능합니다. 다만 크로저는 매개변수 기본값을 사용할 수 없습니다. 이제 backwards(first:second)함수를 클로저
    표현으로 대체해보겠습니다.
 */



/// 13-4 sorted(by:) 메서드에 클로저 전달

//backwards(fisrt:second:) 함수 대신에 sorted(by:)메서드의 전달인자로 클로저를 직접 전달합니다.
/*
let reversed: [String] = names.sorted(by: {
        (first: String, second: String) -> Bool in return first > second
})

 
let reverse: [String] = names.sorted { (first, second) -> Bool in
    return first < second
}

print(reversed)
*/
 
/*
    sorted(by:) 메서드로 전달되는 클로저의 매개변수 개수와 타입, 반환 타입이 모두 backwards(first:second:)함수와
    같다는 것을 눈치챘나요?
    아직 익숙하지 않겠지만, 처음보다 코드가 훨씬 간결해지고 직관적으로 바꼈습니다. 이렇게 프로그래밍하면 sorted(by:) 메서드로
    전달되는 backward(first:second) 함수가 어디에 있는지, 어떻게 구현되어 있는지 찾아다니지 않아도 됩니다. 물론, 
    반복해서 같은 기능을 사용하려면 함수로 구형해주는 것도 나쁘지 않습니다.
 */



/*
    함수나 메서드의 마지막 전달인자로 위치하는 클로저는 함수나 메서드의 소괄호를 닫은 후 작성해도 됩니다. 클로저가  조금
    길어지거나 가독성이 조금 떨어진다 싶으면 후행 클로저 ( Trailing Closure ) 기능을 사용하면 좋습니다. 
    Xcode에서 자동완성 기능을 사용하면 자동으로 후행 클로저로 유도합니다. 단 후생 클로저는 마지막 전달인자로 전달되는 
    클로저에만 해당되므로 전달인자로 클로저가 여러 개 전달될 때에는 맨 마지막 클로저만 후행 클로저로 사용할 수 있습니다. 또한, 
    sorted(by:)메서드처럼 단 하나의 클로저만 전달인자로 전달하는 경우에는 소괄호를 생략해 줄수도 있습니다.
 */

/// 13-5 후행 클로저 표현

/*
let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}

// sorted(by:) 메서드의 소괄호까지 생략 가능합니다.
let revesred: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}
*/

/*
    후행 클로저는 Xcode에서도 자동완성으로 후행 클로저를 사용하도록 유도하므로 자주 볼 겁니다. 또한, 앞으로 배워볼
    맵과 필터 등에서도 계속해서 보게 될 형태이니 잘 기억해두세요.
 */



/*
    클로저 표현 간소화
 
    문맥을 통한 타입 유추
    매서드의 전달인자로 전달되는 클로저는 메서드에서 요구하는 형태로 전달되어야 합니다. 즉, 매개변수의 타입이나 개수, 반환 타입
    등이 같아야 전달인자로 전달이 될 수 있습니다. 이를 다르게 말하면, 전달인자로 전달될 클로저는 이미 그 타입을 준수하고 있다고
    유추할 수도 있습니다. 문맥에 따라 적절히 타입을 유추할 수 있는 거죠. 그래서 전달인자로 전달되는 클로저를 구현할 때는 
    매개변수의 타입이나 반환 값의 타입을 굳이 표현해주지 않고 생략하더라고 문제가 없습니다.
 */

/// 13-6 클로저의 타입유추

// 클로저의 매개변수 타입과 반환 타입을 생략하여 표현할 수 있습니다.

/*
let reversed: [String] = names.sorted { (first, second) -> Bool in
    return first > second
}
*/



/*
    단축 인자 이름
    계속해서 sorted(by:) 메서드로 전달하는 클로저를 살펴보면 또 하나 마음에 들지 않는 점이 있습니다. 바로, 의미없어
    보이는 두 매개변수 이름입니다. 참 멋스럽지 못하게 first, second라니, 정말 아무 의미도 멋도 없습니다. 그래서
    스위프트는 조금 멋스럽고 간결하게 표현할 수 있도록 단축 인자 이름을 제공합니다.
    단축 인자 이름은 첫 번째 전달인자부터 $0,$1,$2,$3... 순서로 $와 숫자의 조합으로 표현합니다.
    단축 인자 표현을 사용하게 괴면 매개변수 및 반환 타입과 실행 코드를 구분하기 위해 사용했던 키워드 in의 사용도
    불필요해 집니다.
 */

/// 13-7 단축 인자 이름 사용

//단축 인자 이름을 사용한 표현

/*
let reversed: [String] = names.sorted {
    return $0 > $1
}
*/



/*
    암시적 반환 표현
    점점 더 간결해지고 있는 크로저 표현을 보고 있습니다. '이제 더 줄일게 없어!', '이제 이정도가 한계야!'라고 생각했지요?
    아직 끝이 아닙니다. 생략할수 이쓴ㄴ 것이 딱하나 남았습니다. 클로저에서는 return 키워드마저 생략할수 있습니다.
    만약 클로저가 반환 값을 갖는 클로저이고 클로저 내부의 실행문이 단 한 줄이라면, 암시적으로 그 실행문이 반환 값으로
    사용될수 있습니다.
 */

/// 13-8 암시적 반환 표현의 사용

// 암시적 반환 표현의 사용

/*
let reversed: [String] = names.sorted { $0 > $1 }
*/


/*
    연산자 함수
    클로저의 장점은 간단한 표현입니다. 처음 소개했던 함수의 표현에서 얼마나 더 간단해졌는지 [코드 13-3]으로 돌아가 확인해
    보세요! 
    우리는 연산자에 대해 알아봤습니다. 비교 연산자는 두 개의 피연산자를 통해 Bool타입의 반환을 줍니다. 우리가 sorted(by:)  
    메소드에 전달한 클로저와 동일한 조건입니다. 클로저는 매개변수의 타입과 반환 타입이 연산자가 구현된 함수의 모양과 동일하다면
    연산자만 표기하더라고 알아서 연산하고 반환합니다. 그 이유는 연산자가 일종의 함수였다는 것 기억 하나요? 스위프트 라이브러이에서
    우리가 사용하는 비교 연산자의 정의를 보자면 다음과 같습니다.
 */


/// 13-9 > 연산자

/*
 > 연산자가 이렇게 정의되어 있다.
public func ><T : Comparable>(lhs: T, rhs: T) -> Bool
*/

/*
    func 키워드가 보이시나요? 함수는 클로저의 일조! 기억사시죠? 여기서 > 자체가 함수의 이름입니다. 더군다나 이 함수는
    우리가 전달인자로 보내기에 충분한 조건을 가지고 있습니다. (물론 아직 제네릭과 프로토콜을 배우기 않아 다 이해는 안되지만 
    T를 String으로만 바꿔서 생각해보세요). 이 얼마나 멋진 조합인가요?
 */



/// 13-10 클로저로서의 연산자 함수 사용
let reversed: [String] = names.sorted(by: >)



/*
    값 획득
    클로저는 자신이 정의된 위치의 주변 문맥을 통해 상수나 변수를 획득(Capture)할 수 있습니다. 값 획득을 통해 클로저는
    주변에 정의된 상수나 변수가 더는 존재하지 않더라도 그 상수나 변수의 값을 자신 내부에서 참조하거나 수정할 수 있습니다.
    이 이야기를 하는 이유는 클로저가 비동기 작업에 많이 사용되기 때문입니다. 클로저를 통해 비동기 콜백call back의 형태를
    작성하는 경우, 현재 상태를 미리 획득해두지 않으면, 실직적으로 클로저의 기능을 수행하는 순간에는 주변의 상수나 변수가 이미
    메모리에 존재하지 않는 경우가 발생합니다.
 
    중첩 함수도 하나의 클로저 형태라고 앞에서 설명했는데, 이 중첩 함수 주변의 변수나 상수를 획득해 놓을 수도 있습니다. 즉,
    자신을 포함하고 있는 함수의 지역변수나 지역상수를 획득할 수 있습니다.
 
    incremeter라는 함수를 중첩 함수로 포함하고 있는 makeIncremeter 함수의 예를 통해 알아보겠습니다.
    중첩 함수인 incremeter() 함수는 자신 주변에 있는 runningTotal과 amount라는 두 값을 획득합니다. 두 값을 
    획득한 후에 incremeter는 클로저로써 makeIncremeter 함수에 의해 반환됩니다.
 */

// 13-11 makeincremeter(forIncremet:)함수

func makeIncremeter(forIncrement amount: Int) -> (()->Int) {
    var runningTotal = 0
    func incremeter() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incremeter
}



/*
    makeIncremeter 함수의 반환 타입은 () -> Int 입니다. 이는 함수객체를 반환한다는 의미입니다. 반환되는 함수는
    매개변수를 받지 않고 바호나 타입은 Int인 함수입니다. 반환된 함수는 호출될 떄마다 Int 타입의 값을 반환해줍니다.
    
    makeIncremeter(forIncremet:)함수는 incremter가 반환하게 될 값을 저장하는 용도로 runningTotal을 정의
    하였고, 0 으로 초기화 해두었습니다.
 
    makeIncremeter(forIncrement:)함수는 icnremter라는 외부 이름을 가지고, amount라는 내부 이름을 가진 
    하나의 Int 타입 매개변수를 가지고 있습니다. incremter() 함수가 호출될 때마다 이 amount의 값만큼 runningTotal
    의 값이 증가합니다.
 
    makeIncremeter(forIncremet:) 함수는 실제로 값을 증가시키는 역할을 수행하는 incremter라는 이름의 중첩 함수를
    정의했습니다. 이 incremeter() 함수는 amount의 값을 runningTotal에 더하여 결괏값을 반환합니다.
    
    incremeter() 함수를 makeIncrementer(forIncremter:) 함수 외부에 독립적으로 떨어뜨려 놓으면 동작할 수 없는
    이상한 형태가 됩니다.
 */

/// 13-12 incremnter() 함수

/*
func incremeter() -> Int {
    runningTotal =+ amount
    return runningTotal
}
*/



/*
    incrementer() 함수는 어떤 매개변수도 갖지 않으며, runningTotal 이라는 변수가 어디 있는지 찾아 볼 수도 없습니다.
    지금 이 형태만으로는 잘못된 코드입니다.
    그러나 incremeter() 함수 주변에 runningTotal과 amount변수가 있다면 incremeter() 함수는 두 변수의 참조를 
    획득할 수 있습니다. 참조를 획득하면 runningTotal과 amount는 makeIncremter 함수의 실행이 끝나도 사라지지
    않습니다. 게다가 incrementer가 호출될 때마다 계속해서 사용할 수 있습니다.
 
    makeIncremeter(forIncremeter:)함수를 사용하여 incremterByTwo라는 이름의 상수에 incremter 함수를 할당
    해줬습니다. incremterByTwo를 호출할 떄 마다 runnintTotal은 값이 2씩 증가합니다.
 */

/// 13-13 incrementByTwo

/*
let incremetByTwo: (() -> Int) = makeIncremeter(forIncrement: 2)

let first: Int = incremetByTwo()
let secont: Int = incremetByTwo()
let third: Int = incremetByTwo()
*/



/// 13-14 각각의 incremter의 동작

/*
let incrementByTwo: (() -> Int) = makeIncremeter(forIncrement: 2)
let incrementByTow2: (() -> Int) = makeIncremeter(forIncrement: 2)

let incremetByTen: (() -> Int) = makeIncremeter(forIncrement: 10)

let first: Int = incrementByTwo()
let second: Int = incrementByTwo()
let third: Int = incrementByTwo()

let first2: Int = incrementByTow2()
let second2: Int = incrementByTow2()
let third2: Int = incrementByTow2()

let ten: Int = incremetByTen()
let twenty: Int = incremetByTen()
let thirty: Int = incremetByTen()
 */

/*
    각각의 incremter 함수는 언제 호출이 되어도 자신만의 runningTotal 변수를 가지고 카운트를 하게 됩니다. 
    다른 함수의 영향도 전혀 받지 않습니다. 각각 자신만의 runningTotal의 참조를 미리 획득했기 때문입니다.
 
    클래스 인스턴스의 프로퍼티로 클로저를 할당한다면 클로저는 그 인스턴스 또는 인스턴스의 멤버의 참조를 획득할 수 있으나
    클로저와 인스턴스 사이에 가한 참조 순환 문제가 발생할수 있습니다. 강한참조 순환 문제는 획득목록을 통해 없앨 수 있습니다.
 
    !!!
    클로저는 한번 캡쳐를 하면 그 캡쳐값을 계속해서 가지고 있는것 같다. ( 블럭도 그렇지 않을까 생각된다 )
 */



/*
    값 획득 부분의 예제에서 incrementByTwo와 incrementByTen은 모두 상수 입니다. 이 두 상수 클로저들은 값 획득을 
    통해 runningTotal을 계속해서 증가시킬 수 있습니다. 왜냐하면 함수와 클로저는 참조 타입이기 때문입니다. 
 
    함수나 클로저를 상수나 변수에 할당할 때마다 사실은 상수나 변수에 함수나 클로저의 참조를 세팅하는 것입니다.
    즉 incremeterByTwo라는 상수에 클로저를 할당한다는 것이 아니라 해당 클로저의 참조를 할당하는 것입니다. ( 클로저의 주소 )를 저장한다는 말인듯
    
    !!!
    결국 클로저의 참조를 다른 상수에 할당해준다면 이는 두상수가 모두 같은 클로저를 가리킨다는 뜻입니다.
 */

/// 13-15 참조 타입인 클로저

let incrementByTwo: (() -> Int) = makeIncremeter(forIncrement: 2)
let sameWithIncremetByTwo: (() -> Int) = incrementByTwo

let first: Int = incrementByTwo()
let second: Int = sameWithIncremetByTwo()



/*
    탈출 클로저
 
    함수의 전달인자로 전달된 클로저가 함수 종료 후에 호출될 떄 클로저가 함수를 탈출(Escape)한다고 표현합니다.
    클로저를 매개변수로 갖는 함수를 선언할 때 매개변수 이름의 콜론(:)뒤에 @escaping 키워드를 사용하여 클로저가 탈출
    하는것을 허용한다고 명시해줄 수 있습니다.
 
    예를 들어 비동기 작업을 수행하는 함수들이 클로저를 컴플리션 핸들러 Completion handler 전달인자로 받아옵니다.
    비동기 작업으로 함수가 종료되고 난 후 작업이 끝나고 호출될 필요가 있는 클로저를 사용해야 할 때 탈출 클로저가
    필요합니다.
 
    그런데 sorted(by:) 메서드를 비롯하여 계속 살펴보았던 함수에는 @escaping 키워드를 찾아볼 수 없습니다. 정렬될 요소를 
    비교연산하기 위해 전달인자로 전달하는 클로저는 비탈출 클로저이기 때문입니다. @escaping 키워드를 따로 명시하지 않는다면
    매개변수로 사용되는 크로저는 기본으로 비탈출 클로저입니다. 비탈출 클로저는 함수의 동작이 끝난 후 전달된 클로저가 
    필요없을 때 사용합니다. 
 
    클로저가 함수를 탈출할 수 있는 경우 중 하나는 함수 외부에 정의된 변수나 상수에 저장되어 함수가 종료된 후에 사용될
    경우입니다. 예를 들어 비동기적으로 작업을 수행하기 위해서 컴플리션 핸들러를 클로저의 형태로 전달인자를 통해 받는 함수들이
    많습니다. 함수가 작업을 종료하고 난 이후(즉, 함수의 return 후)에 컴플리션 핸들러, 즉 클로저가 호출되기 때문에 클로저는
    함수를 탈출해 있어야만 합니다. 함수의 전달인자로 전달받은 클로저를 다시 반환할 때에도 마찬가지입니다. 탈출 클로저와 그 
    클로저를 저장할 수 있는 함수 회부의 배열 변수를 볼 수 있습니다.
 */

/// 13-16 탈출 클로저를 매개변수로 갖는 함수

var completionHandlers: [()->Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}



/// 13-17 함수를 탈출하는 클로저의 예

/*
typealias VoidVoidClosure = () -> Void

let firstClosure: VoidVoidClosure = {
    print("Closure A")
}

let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될수 있으므로 탈출 클로저입니다.
func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
    return shouldReturnFirstClosure ? first : second
}

// 함수에서 반환된 클로저가 함수 외부의 상수에 저장되었습니다.

let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnedClosure()   // Closure A

var closures: [VoidVoidClosure] = []

// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저입니다. 
func appendClosure(closure: @escaping VoidVoidClosure) {
    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출합니다.
    closures.append(closure)
}
*/

/*
    두 함수의 전달인자로 전달되는 클로저 앞에 @escaping 키워드를 명시하여 탈출 클로저임을 명시해 주어야 합니다.
    이 코드는 클로저가 모두 탈출할 수 있는 조건이 명확하기 때문에 @escaping 키워드를 명시하여 탈출 클로저임을 
    명시하지 않으면 컴파일 오류가 발생합니다. 이 코드는 함수 외부로 다시 전달되어 외부에서 사용이 가능하다든가, 외부
    변수에 저장되는 등의 클로저의 탈출 조건을 모두 갖추고 있습니다.
 
    타입 내부 메서드의 매개변수 클로저에 @escaping 키워드를 사용하여 탈출 클로저임을 명시한 경우, 클로저 내부에서
    해당 타입의 프로퍼티나 메서드, 서브스크립트 등에 접근하려면 self 키워드를 명시적으로 사용해야 합니다. 비탈출 클로저는
    클로저 내부에서 타입 내부의 프로퍼티나 메서드 서브스크립트 등에 접근할 때 self 키워드를 꼭 써주지 않아도 됩니다.
    즉 비탈출 클로저 내부에서 self 키워드는 선택 사항입니다.
 
    !!!
    결국 매개변수로 들어온 클로저가 그대로 반환될수 있을때 escaping 키워드를 사용해서 표시해주는것 같다.
    외부에 closures에 함수의 매개변수로 들어온 closure가 저장되기 때문에 escaping을 사용해야 하는것 같다.
 
 */



/// 13-18 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저
typealias VoidVoidClosure = () -> Void

func functionWithNoescapeClosure(closure: VoidVoidClosure) {
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return  completionHandler
}

class SomeClass {
    var x = 10
    
    func runNoescapeClosure() {
        // 비탈출 클로저에서 self 사용은 선택 사항입니다.
        functionWithNoescapeClosure { x += 200 }
    }
    
    func runEscapingClosure() -> VoidVoidClosure {
        // 탈출 클로저에서 명시적으로 self를 사용해야 합니다.
        return functionWithEscapingClosure {
            self.x += 100
        }
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x)   // 200

let returnedClosure: VoidVoidClosure = instance.runEscapingClosure()
returnedClosure()
print(instance.x)   // 100

/*
    비탈출 클로저에서는 인스턴스의 프로퍼티인 x를 사용하기 위해 self 키워드를 생략해도 무관했지만, 탈출하는 클로저에서는
    값 획득을 하기 위해 self 키워드를 사용하여 프로퍼티에 접근해야만 합니다.
 
    !!!
    클로저는 참조형태이기 때문에 instanc.runEscapingClosure는 참조를 반환해서 같은 instance의 값을 변경하는 것이다.
 */



/*
    자동 클로저
    함수의 전달인자로 전달되는 표현을 자동으로 변해주는 클로저를 자동 클로저(Auto Closure)라고 합니다. 자동 클로저는
    전달인자를 갖지 않습니다. 자동 클로저는 호출되었을 때 자신이 감싸고 있는 코드의 결과값을 반환합니다. 자동 클로저는 
    함수로 전달되는 클로저를 ( 소괄호와 중괄호를 겹쳐서 써야하는 ) 어려운 클로저 문법을 사용하지 않고도 클로저로 사용할 수 
    있도록 문법적 편의를 제공합니다.
 
    스위프트 표준 라이브러리에는 자동 클로저를 호출하는 함수가 구현되어 있어 이를 사용하는 일이 종종 있습니다. 하지만 직접
    자동 클로저를 호출하는 함수를 구현하는 일은 흔치 않을 겁니다. 예를 들어 스위프트 표준 라이브러리에 구현되어 있는 
    assert(condition:message:file:line:) 함수는 condition과 message 매개변수가 자동 클로저입니다. 
    condition매개변수는 디버그용 빌드에서만 실행되고, message 매개변수는 condition 매개변수가 false일 때만 
    실행됩니다. 
 
    자동 클로저는 클로저가 호출되기 전까지는 클로저 내부의 코드는 동작하지 않습니다. 따라서 연산을 지연시킬 수 있습니다.
    이 과정은 연산에 자원이 많이 소모된다거나 부작용이 우려 될 떄 사용할 수 있습니다. 왜냐하면 코드의 실행을 제어하기 
    좋기 때문입니다.
 
 */

/// 13-19 클로저를 이용한 연산 지연

/*
// 대기 중인 손님들입니다.
var customersInLine: [String] = ["YoangWha", "SangYoung", "SungHun", "HaMi"]
print(customersInLine.count)    // 4

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
    customerProvider 상수에 저장해둔 클로저는 하나의 명령문 묶음으로 볼 수 있습니다. Array의 removeFirst() 메서드는
    자신의 첫 번째 요소를 제거하면서 그 요소를 반환해주는 메서드였던 것 기억하시나요? 그래서 customerProvider()가
    선언되었지만 바로 아래서 호출한 print(cutomerInLine.count) 코드에서 클로저 내부의 연산이 반연되지 않으며 클로저가
    실제로 실행되기 전까지는 reomveFirst 메서드가 연산되지도 않습니다. 그 뒤에 실제로 클로저를 실행하게 되면 그때서야
    연산을 수행하게 됩니다. 클로저가 영영 호출되지 않는다면 내부의 코드도 실행되지 않기 때문에 해당 연산은 수행되지 않습니다.
    우리가 이제껏 알고 있던 클로저의 활용과 크게 다르지 않은 내용입니다.
*/



/// 13-20 함수의 전달인자로 전달되는 클로저

/*
customersInLine is ["YoangWha", "SangYong", "SungHun", "HaMi"]


func serveCustomer(_ customerProvider: ()->String) {
    print("Now serving \(customerProvider())")
}

serveCustomer({ customersInLine.removeFirst() })    // "Now serving YoangWha!"
*/
 
/*
    우리가 이제껏 봐왔던 모양과 크게 다르지 않습니다. 함수의 전달인자로 직접 클로저를 작성하여 전달해주었습니다.
    코드의 serveCustomer(_:) 함수는 클로저를 매개변수로 전달받고 있습니다.
 
    암시적 반환 표현
    [코드 13-19]와 [코드 13-20]이 다른 이유는 return을 암시적 반환으로 표현한것과 하지 않은 것이다.
 */



/// 13-21 자동 클로저의 사용

/*
//customersInLine is ["YouangWha", "SangYoung", "SungHun", "HaMi"]
func serveCustomer(_ customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serveCustomer(customersInLine.removeFirst())
*/

/*
    기존의 serveCustomer(_:) 함수와 동일한 역확을 수행하지만 매개변수에 @autoclosure 속성을 주었기 때문에
    자동 클로저 속성을 부여한 매개변수는 클로저 대신에 customersInLine.removeFirst() 코드의 실행 결과인 
    String 타입의 문자열을 전달인자로 받게 됩니다. String 타입의 값이 자동 클로저 매개변수에 전달되면 String
    값을 매개변수가 없는 String 값을 반환하는 클로저로 변환해줍니다. String 타입의 값을 전달 받는 이유는 자동 
    클로저의 반환 타입이 String이기 때문입니다. 자동 클로저는 전달인자를 갖지 않기 때문에 반환 인자의 값이 자동 클로저의 
    매개변수로 전달되면 이를 클로저로 바꿔줄 수 있는 것입니다. 이렇게 String 값으로 전달된 전달인자가 자동으로 
    클로저로 변환되기 때문에 자동 클로저라고 부릅니다.
    자동 클로저를 사용하면 기본의 사용 방법처럼 클로저를 전달이나조 넘겨주는 것은 불가능 합니다.
 
    기본적으로 @autoclosure 속성은 @noescape 속성을 포함합니다. 즉 @autoclosure 속성을 사용하면 @nonescape
    속성도 부여되는 것을 암시하는 것입니다. 만약 자동 클로저를 탈출하는 클로저로 사용하고 싶다면 @autoclosure 속성 뒤에
    @escaping 속성을 덧붙여서 @autoclosure @escaping 처럼 사용하면 됩니다.
*/



/// 13-22 자동 클로저의 탈출

var customersInLine: [String] = ["minjae","innoceive","sopress"]

func returnProvider( _ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
    return customerProvider
}

let customerProvier: () -> String = returnProvider(customersInLine.removeFirst())
print("Now serving \(customerProvier())!") // "Now serving minjae!"

/*
    탈출 가능한 자동 클로저를 매개변수로 받아서 반환 값으로 반환하는 returnProvider(_:) 함수가 있습니다.
    이 함수의 전달인자로 전달된 후 클로저로 변환된 코드들이 그대로 클로저의 형태로 반화되는 것을 알 수 있습니다.
    즉, 함수를 탈출하는 클로저가 되는 것입니다. 그래서 @autoclosure @ escaping 속성을 사용해야 합니다.
 */





